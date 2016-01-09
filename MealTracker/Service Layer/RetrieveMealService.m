//
//  RetrieveMealService.m
//  MealTracker
//
//  Created by William Hindenburg on 2/12/15.
//
//

#import "RetrieveMealService.h"
#import "MealTracker-Swift.h"

@implementation RetrieveMealService

- (void)retrieveMealsWithSuccessBlock:(void (^)(NSArray<Meal *> *meals))successBlock andError:(void (^)(NSError *error))errorBlock {
//    ServiceClient *serviceClient = [ServiceClient new];
//    [serviceClient getForService:self withSuccess:^(RKMappingResult *result) {
//        successBlock(result.array);
//    } andError:^(NSError *error) {
//        errorBlock(error);
//    }];
}

- (NSString *)serviceURL {
    NSString *serviceString = [NSString stringWithFormat:@"/1/classes/%@", NSStringFromClass([Meal class])];
    return serviceString;
}

- (NSString *)rootKeyPath {
    return @"results";
}

- (NSString *)rootRequestKeyPath {
    return nil;
}

- (NSDictionary *)parameters {
    return nil;
}

//- (RKObjectMapping *)mappingProvider {
//    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Meal class]];
//    [mapping addAttributeMappingsFromDictionary:@{@"calories":@"calories"}];
//    [mapping addAttributeMappingsFromDictionary:@{@"carbs":@"carbs"}];
//    [mapping addAttributeMappingsFromDictionary:@{@"dietaryFiber":@"dietaryFiber"}];
//    [mapping addAttributeMappingsFromDictionary:@{@"mealDescription":@"mealDescription"}];
//    [mapping addAttributeMappingsFromDictionary:@{@"name":@"name"}];
//    [mapping addAttributeMappingsFromDictionary:@{@"protein":@"protein"}];
//    [mapping addAttributeMappingsFromDictionary:@{@"servingSize":@"servingSize"}];
//    [mapping addAttributeMappingsFromDictionary:@{@"totalFat":@"totalFat"}];
//    [mapping addAttributeMappingsFromDictionary:@{@"weightWatchersPlusPoints":@"weightWatchersPlusPoints"}];
//    [mapping addAttributeMappingsFromDictionary:@{@"whenEaten":@"whenEaten"}];
//    [mapping addAttributeMappingsFromDictionary:@{@"objectId":@"objectId"}];
//    return mapping;
//}

@end
