//
//  ServiceClient.h
//  Life
//
//  Created by William Hindenburg on 1/4/15.
//  Copyright (c) 2015 William Hindenburg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RestKit/RestKit.h"
#import "Service.h"

extern NSString* const LifeServiceErrorDomain;

@interface ServiceClient : NSObject

- (void)postObject:(id)object andService:(id<Service>)lifeService withSuccessBlock:(void (^)(RKMappingResult *result))successBlock andError:(void (^)(NSError *error))errorBlock;

- (void)putObject:(id)object andService:(id<Service>)lifeService withSuccessBlock:(void (^)(RKMappingResult *result))successBlock andError:(void (^)(NSError *error))errorBlock;

- (void)getForService:(id<Service>)service withSuccess:(void (^)(RKMappingResult *result))successBlock andError:(void (^)(NSError *error))errorBlock;

- (void)deleteObject:(id)object andService:(id<Service>)lifeService withSuccessBlock:(void (^)(RKMappingResult *result))successBlock andError:(void (^)(NSError *error))errorBlock;

- (void)deleteObjects:(NSArray *)objects andService:(id<Service>)lifeService withSuccessBlock:(void (^)(RKMappingResult *result))successBlock andError:(void (^)(NSError *error))errorBlock;

@end
