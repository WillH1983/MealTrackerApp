//
//  SavePrivateMessageService.m
//  Life
//
//  Created by William Hindenburg on 1/14/15.
//  Copyright (c) 2015 William Hindenburg. All rights reserved.
//

#import "RestKit/RestKit.h"

#import "SaveMealService.h"
#import "ServiceClient.h"
#import "MealData.h"

@interface SaveMealService()
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *keyPath;
@property (strong, nonatomic) NSString *mealObjectId;
@property (assign, nonatomic) BOOL isUpdatingMeal;
@end

@implementation SaveMealService

- (void)saveMeal:(MealData *)meal withSuccessBlock:(void (^)())successBlock andError:(void (^)(NSError *error))errorBlock {
    ServiceClient *serviceClient = [ServiceClient new];
    [serviceClient postObject:meal andService:self withSuccessBlock:^(RKMappingResult *result) {
        NSLog(@"%@", result.firstObject);
    } andError:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)updateMeal:(MealData *)meal withSuccessBlock:(void (^)())successBlock andError:(void (^)(NSError *error))errorBlock {
    self.isUpdatingMeal = YES;
    self.mealObjectId = meal.objectId;
    ServiceClient *serviceClient = [ServiceClient new];
    [serviceClient putObject:meal andService:self withSuccessBlock:^(RKMappingResult *result) {
        successBlock();
    } andError:^(NSError *error) {
        errorBlock(error);
    }];
}

//- (void)updatePrivateMessage:(PrivateMessage *)privateMessage fromCapsule:(Capsule *)capsule withSuccessBlock:(void (^)())successBlock andError:(void (^)(NSError *error))errorBlock {
//    self.url = [NSString stringWithFormat:@"/1/classes/%@/%@", NSStringFromClass([PrivateMessage class]), privateMessage.objectId];
//    ServiceClient *serviceClient = [ServiceClient new];
//    [serviceClient putObject:privateMessage andService:self withSuccessBlock:successBlock andError:errorBlock];
//}

- (NSString *)serviceURL {
    if (self.isUpdatingMeal) {
        return [NSString stringWithFormat:@"/1/classes/%@/%@", NSStringFromClass([MealData class]), self.mealObjectId];
    } else {
        return [NSString stringWithFormat:@"/1/classes/%@", NSStringFromClass([MealData class])];
    }
}

- (NSString *)rootKeyPath {
    return nil;
}

- (NSString *)rootRequestKeyPath {
    return nil;
}

- (NSDictionary *)parameters {
    return nil;
}

- (RKObjectMapping *)mappingProvider {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[MealData class]];
    [mapping addAttributeMappingsFromDictionary:@{@"objectId":@"objectId"}];
    return mapping;
}

- (RKObjectMapping *)serializedMappingProvider {
    RKObjectMapping *seriallMapping = [RKObjectMapping mappingForClass:[MealData class]];
    [seriallMapping addAttributeMappingsFromDictionary:@{@"calories":@"calories"}];
    [seriallMapping addAttributeMappingsFromDictionary:@{@"carbs":@"carbs"}];
    [seriallMapping addAttributeMappingsFromDictionary:@{@"dietaryFiber":@"dietaryFiber"}];
    [seriallMapping addAttributeMappingsFromDictionary:@{@"mealDescription":@"mealDescription"}];
    [seriallMapping addAttributeMappingsFromDictionary:@{@"name":@"name"}];
    [seriallMapping addAttributeMappingsFromDictionary:@{@"protein":@"protein"}];
    [seriallMapping addAttributeMappingsFromDictionary:@{@"servingSize":@"servingSize"}];
    [seriallMapping addAttributeMappingsFromDictionary:@{@"totalFat":@"totalFat"}];
    [seriallMapping addAttributeMappingsFromDictionary:@{@"weightWatchersPlusPoints":@"weightWatchersPlusPoints"}];
    [seriallMapping addAttributeMappingsFromDictionary:@{@"whenEaten":@"whenEaten"}];
    
    
    return seriallMapping;
}

@end
