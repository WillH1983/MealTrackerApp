//
//  ServiceClient.m
//  Life
//
//  Created by William Hindenburg on 1/4/15.
//  Copyright (c) 2015 William Hindenburg. All rights reserved.
//


#import "ServiceClient.h"
#import "MealServiceErrors.h"
#import "RestKit/Restkit.h"
#import "User.h"

NSString* const LifeServiceErrorDomain = @"com.LifeServices.Life";

@implementation ServiceClient

- (void)postObject:(id)object andService:(id<Service>)lifeService withSuccessBlock:(void (^)(RKMappingResult *result))successBlock andError:(void (^)(NSError *error))errorBlock {
    if ([lifeService respondsToSelector:@selector(serviceURL)] &&
        [lifeService respondsToSelector:@selector(baseURL)]) {
        RKObjectManager *objectManager = [self objectManagerForService:lifeService];
        [objectManager postObject:object path:[lifeService serviceURL] parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
            if (successBlock) successBlock(mappingResult);
        } failure:^(RKObjectRequestOperation *operation, NSError *error) {
            if (errorBlock) errorBlock(error);
        }];
    }

}

- (void)putObject:(id)object andService:(id<Service>)lifeService withSuccessBlock:(void (^)(RKMappingResult *result))successBlock andError:(void (^)(NSError *error))errorBlock {
    if ([lifeService respondsToSelector:@selector(serviceURL)] &&
        [lifeService respondsToSelector:@selector(baseURL)]) {
        RKObjectManager *objectManager = [self objectManagerForService:lifeService];
        [objectManager putObject:object path:[lifeService serviceURL] parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
            if (successBlock) successBlock(mappingResult);
        } failure:^(RKObjectRequestOperation *operation, NSError *error) {
            if (errorBlock) errorBlock(error);
        }];
    }
}

- (RKObjectManager *)objectManagerForService:(id<Service>)service {
    RKObjectManager *objectManager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:[service baseURL]]];
    [objectManager setAcceptHeaderWithMIMEType:@"*/*"];
    [objectManager setRequestSerializationMIMEType:RKMIMETypeJSON];
    
    [objectManager addResponseDescriptor:[RKResponseDescriptor responseDescriptorWithMapping:[self getMappingForService:service] method:RKRequestMethodGET pathPattern:nil keyPath:[service rootKeyPath] statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)]];
    
    RKRequestDescriptor *request = [RKRequestDescriptor requestDescriptorWithMapping:[self getSerializationMappingForService:service] objectClass:[self getSerializationObjectClassForService:service] rootKeyPath:[service rootRequestKeyPath] method:RKRequestMethodPOST|RKRequestMethodPUT|RKRequestMethodDELETE];
    [objectManager addRequestDescriptor:request];
        
    User *user = [User persistentUserObject];
    if (user.sessionToken) {
        [objectManager.HTTPClient setDefaultHeader:@"X-Parse-Session-Token" value:user.sessionToken];
    }
    
    [objectManager.HTTPClient setDefaultHeader:@"X-Parse-Application-Id" value:@"Wme1ksSkFZg9S4RyXWwvl7qsg6vREiSKk971ums0"];
    [objectManager.HTTPClient setDefaultHeader:@"X-Parse-REST-API-Key" value:@"AzU3ZJMuvgWDj5ladeVSLmQozm04MJL8yA8OGI44"];
    RKLogConfigureByName("RestKit/Network", RKLogLevelTrace);
    return objectManager;
}

- (void)getForService:(id<Service>)service withSuccess:(void (^)(RKMappingResult *result))successBlock andError:(void (^)(NSError *error))errorBlock {
    if ([service respondsToSelector:@selector(serviceURL)] &&
        [service respondsToSelector:@selector(baseURL)]) {
        RKObjectManager *objectManager = [self objectManagerForService:service];

        [objectManager getObjectsAtPath:[service serviceURL] parameters:[service parameters] success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
            successBlock(mappingResult);
        } failure:^(RKObjectRequestOperation *operation, NSError *error) {
            errorBlock(error);
        }];
        
    }
}

- (void)deleteObject:(id)object andService:(id<Service>)lifeService withSuccessBlock:(void (^)(RKMappingResult *result))successBlock andError:(void (^)(NSError *error))errorBlock {
    [self deleteObjects:@[object] andService:lifeService withSuccessBlock:successBlock andError:errorBlock];
}

- (void)deleteObjects:(NSArray *)objects andService:(id<Service>)lifeService withSuccessBlock:(void (^)(RKMappingResult *result))successBlock andError:(void (^)(NSError *error))errorBlock {
    if ([lifeService respondsToSelector:@selector(serviceURL)] &&
        [lifeService respondsToSelector:@selector(baseURL)]) {
        RKObjectManager *objectManager = [self objectManagerForService:lifeService];
        [objectManager postObject:objects path:[lifeService serviceURL] parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
            if (successBlock) successBlock(mappingResult);
        } failure:^(RKObjectRequestOperation *operation, NSError *error) {
            if (errorBlock) errorBlock(error);
        }];
    }
}

- (Class)getSerializationObjectClassForService:(id<Service>)service {
    
    if ([service respondsToSelector:@selector(serializedMappingProvider)]) {
        return [service serializedMappingProvider].objectClass;
    }
    
    return [NSMutableDictionary class];
}

- (RKObjectMapping *)getSerializationMappingForService:(id<Service>)service {
    RKObjectMapping *serializationMapping = nil;
    
    if ([service respondsToSelector:@selector(serializedMappingProvider)]) {
        serializationMapping = [[service serializedMappingProvider] inverseMapping];
        
        if (serializationMapping) {
            [serializationMapping setSetNilForMissingRelationships:YES];
        }
    }
    if (!serializationMapping) {
        return [RKObjectMapping mappingForClass:[NSMutableDictionary class]];
    }
    return serializationMapping;
}

- (RKObjectMapping *)getMappingForService:(id<Service>)service {
    RKObjectMapping *mapping = nil;
    
    if ([service respondsToSelector:@selector(mappingProvider)]) {
        mapping = [service mappingProvider];
        
        if (mapping) {
            [mapping setSetNilForMissingRelationships:YES];
        }
    }
    if (!mapping) {
        return [RKObjectMapping mappingForClass:[NSMutableDictionary class]];
    }
    return mapping;
}

@end
