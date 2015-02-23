//
//  SavePrivateMessageService.m
//  Life
//
//  Created by William Hindenburg on 1/14/15.
//  Copyright (c) 2015 William Hindenburg. All rights reserved.
//

#import <BaseClasses/RestKit/RestKit.h>
#import <BaseClasses/ServiceClient.h>

#import "SaveMealService.h"
#import "Meal.h"

@interface SaveMealService()
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *keyPath;
@property (strong, nonatomic) NSString *mealObjectId;
@property (assign, nonatomic) BOOL isUpdatingMeal;
@end

@implementation SaveMealService

- (void)saveMeal:(Meal *)meal withSuccessBlock:(void (^)(Meal *meal))successBlock andError:(void (^)(NSError *error))errorBlock {
    ServiceClient *serviceClient = [ServiceClient new];
    [serviceClient postObject:meal andService:self withSuccessBlock:^(RKMappingResult *result) {
        successBlock(result.firstObject);
    } andError:^(NSError *error) {
        errorBlock(error);
    }];
}

- (void)updateMeal:(Meal *)meal withSuccessBlock:(void (^)())successBlock andError:(void (^)(NSError *error))errorBlock {
    self.isUpdatingMeal = YES;
    self.mealObjectId = meal.objectId;
    ServiceClient *serviceClient = [ServiceClient new];
    [serviceClient putObject:meal andService:self withSuccessBlock:^(RKMappingResult *result) {
        successBlock();
    } andError:^(NSError *error) {
        errorBlock(error);
    }];
}

- (NSString *)serviceURL {
    if (self.isUpdatingMeal) {
        return [NSString stringWithFormat:@"/1/classes/%@/%@", NSStringFromClass([Meal class]), self.mealObjectId];
    } else {
        return [NSString stringWithFormat:@"/1/classes/%@", NSStringFromClass([Meal class])];
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
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Meal class]];
    [mapping addAttributeMappingsFromDictionary:@{@"objectId":@"objectId"}];
    return mapping;
}

- (RKObjectMapping *)serializedMappingProvider {
    RKObjectMapping *seriallMapping = [RKObjectMapping mappingForClass:[Meal class]];
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
