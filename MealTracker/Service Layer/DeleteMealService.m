//
//  DeleteMealService.m
//  MealTracker
//
//  Created by William Hindenburg on 2/15/15.
//
//

#import "DeleteMealService.h"
#import "ServiceClient.h"
#import "Meal.h"
#import "RestKit/RestKit.h"

@implementation DeleteMealService

- (void)removeMeals:(NSArray *)meals withSuccessBlock:(void (^)())successBlock andError:(void (^)(NSError *error))errorBlock {
    for (Meal *meal in meals) {
        meal.method = @"DELETE";
        meal.path = [self deletePathWithObjectId:meal.objectId];
    }
    
    ServiceClient *serviceClient = [ServiceClient new];
    [serviceClient deleteObjects:meals andService:self withSuccessBlock:^(RKMappingResult *result) {
        [self cleanupMealArrayAfterServiceCall:meals];
        if (successBlock) successBlock();
    } andError:^(NSError *error) {
        [self cleanupMealArrayAfterServiceCall:meals];
        if (errorBlock) errorBlock(error);
    }];
}

- (void)removeMeal:(Meal *)meal withSuccessBlock:(void (^)())successBlock andError:(void (^)(NSError *error))errorBlock {
    meal.method = @"DELETE";
    meal.path = [self deletePathWithObjectId:meal.objectId];
    
    ServiceClient *serviceClient = [ServiceClient new];
    [serviceClient deleteObject:meal andService:self withSuccessBlock:^(RKMappingResult *result) {
        [self cleanupMealAfterServiceCall:meal];
        if (successBlock) successBlock();
    } andError:^(NSError *error) {
        [self cleanupMealAfterServiceCall:meal];
        if (errorBlock) errorBlock(error);
    }];
}

- (NSString *)deletePathWithObjectId:(NSString *)objectId {
    return [NSString stringWithFormat:@"/1/classes/%@/%@", NSStringFromClass([Meal class]), objectId];
}

- (void)cleanupMealArrayAfterServiceCall:(NSArray *)capsuleArray {
    for (Meal *meal in capsuleArray) {
        [self cleanupMealAfterServiceCall:meal];
    }
}

- (void)cleanupMealAfterServiceCall:(Meal *)meal {
    meal.method = nil;
    meal.path = nil;
}

- (NSString *)serviceURL {
    return @"/1/batch";
}

- (NSString *)rootRequestKeyPath {
    return @"requests";
}

- (NSString *)rootKeyPath {
    return @"";
}

- (RKObjectMapping *)serializedMappingProvider {
    RKObjectMapping *seriallMapping = [RKObjectMapping mappingForClass:[Meal class]];
    [seriallMapping addAttributeMappingsFromDictionary:@{@"method":@"method"}];
    [seriallMapping addAttributeMappingsFromDictionary:@{@"path":@"path"}];
    
    return seriallMapping;
}

@end
