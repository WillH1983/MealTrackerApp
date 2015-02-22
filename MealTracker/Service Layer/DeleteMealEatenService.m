//
//  DeleteMealEaten.m
//  MealTracker
//
//  Created by William Hindenburg on 2/15/15.
//
//

#import <BaseClasses/ServiceClient.h>

#import "DeleteMealEatenService.h"
#import "MealEaten.h"
#import "RestKit/RestKit.h"

@implementation DeleteMealEatenService

- (void)removeMealsEaten:(NSArray *)mealsEaten withSuccessBlock:(void (^)())successBlock andError:(void (^)(NSError *error))errorBlock {
    for (MealEaten *mealEaten in mealsEaten) {
        mealEaten.method = @"DELETE";
        mealEaten.path = [self deletePathWithObjectId:mealEaten.objectId];
    }
    
    ServiceClient *serviceClient = [ServiceClient new];
    [serviceClient deleteObjects:mealsEaten andService:self withSuccessBlock:^(RKMappingResult *result) {
        [self cleanupMealArrayAfterServiceCall:mealsEaten];
        if (successBlock) successBlock();
    } andError:^(NSError *error) {
        [self cleanupMealArrayAfterServiceCall:mealsEaten];
        if (errorBlock) errorBlock(error);
    }];
}

- (void)removeMealEaten:(MealEaten *)mealEaten withSuccessBlock:(void (^)())successBlock andError:(void (^)(NSError *error))errorBlock {
        mealEaten.method = @"DELETE";
        mealEaten.path = [self deletePathWithObjectId:mealEaten.objectId];
    
    ServiceClient *serviceClient = [ServiceClient new];
    [serviceClient deleteObject:mealEaten andService:self withSuccessBlock:^(RKMappingResult *result) {
        [self cleanupMealAfterServiceCall:mealEaten];
        if (successBlock) successBlock();
    } andError:^(NSError *error) {
        [self cleanupMealAfterServiceCall:mealEaten];
        if (errorBlock) errorBlock(error);
    }];
}

- (NSString *)deletePathWithObjectId:(NSString *)objectId {
    return [NSString stringWithFormat:@"/1/classes/%@/%@", NSStringFromClass([MealEaten class]), objectId];
}

- (void)cleanupMealArrayAfterServiceCall:(NSArray *)capsuleArray {
    for (MealEaten *meal in capsuleArray) {
        [self cleanupMealAfterServiceCall:meal];
    }
}

- (void)cleanupMealAfterServiceCall:(MealEaten *)meal {
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
    RKObjectMapping *seriallMapping = [RKObjectMapping mappingForClass:[MealEaten class]];
    [seriallMapping addAttributeMappingsFromDictionary:@{@"method":@"method"}];
    [seriallMapping addAttributeMappingsFromDictionary:@{@"path":@"path"}];
    
    return seriallMapping;
}

@end
