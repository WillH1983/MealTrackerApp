//
//  UserService.m
//  MealTracker
//
//  Created by William Hindenburg on 2/17/15.
//
//

#import <BaseClasses/ServiceClient.h>
#import <BaseClasses/User.h>

#import "UserService.h"
#import <BaseClasses/RestKit/RestKit.h>

@interface UserService()
@property (strong, nonatomic) NSString *objectId;
@end

@implementation UserService

- (void)updateUser:(User *)user withSuccessBlock:(void (^)(User *user))successBlock andError:(void (^)(NSError *error))errorBlock {
    self.objectId = user.objectId;
    ServiceClient *serviceClient = [ServiceClient new];
    [serviceClient putObject:user andService:self withSuccessBlock:^(RKMappingResult *result) {
        successBlock(user);
    } andError:^(NSError *error) {
        errorBlock(error);
    }];
}

- (NSString *)serviceURL {
    return [NSString stringWithFormat:@"/1/users/%@", self.objectId];
}

- (NSString *)rootKeyPath {
    return nil;
}

- (NSString *)rootRequestKeyPath {
    return nil;
}

- (RKObjectMapping *)serializedMappingProvider {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[User class]];
    [mapping addAttributeMappingsFromDictionary:@{@"objectId":@"objectId"}];
    [mapping addAttributeMappingsFromDictionary:@{@"sessionToken":@"sessionToken"}];
    [mapping addAttributeMappingsFromDictionary:@{@"username":@"username"}];
    [mapping addAttributeMappingsFromDictionary:@{@"pointsPerWeek":@"pointsPerWeek"}];
    return mapping;
}

@end
