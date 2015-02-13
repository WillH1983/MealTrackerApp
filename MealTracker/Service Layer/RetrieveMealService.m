//
//  RetrieveMealService.m
//  MealTracker
//
//  Created by William Hindenburg on 2/12/15.
//
//

#import "RestKit/RestKit.h"
#import "RetrieveMealService.h"
#import "MealData.h"
#import "ServiceClient.h"

@implementation RetrieveMealService

- (void)retrieveMealsWithSuccessBlock:(void (^)(NSArray *meals))successBlock andError:(void (^)(NSError *error))errorBlock {
    ServiceClient *serviceClient = [ServiceClient new];
    [serviceClient getForService:self withSuccess:^(RKMappingResult *result) {
        successBlock(result.array);
    } andError:^(NSError *error) {
        errorBlock(error);
    }];
}

- (NSString *)serviceURL {
    NSString *serviceString = [NSString stringWithFormat:@"/1/classes/%@", NSStringFromClass([MealData class])];
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

- (RKObjectMapping *)mappingProvider {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[MealData class]];
    [mapping addAttributeMappingsFromDictionary:@{@"calories":@"calories"}];
    [mapping addAttributeMappingsFromDictionary:@{@"carbs":@"carbs"}];
    [mapping addAttributeMappingsFromDictionary:@{@"dietaryFiber":@"dietaryFiber"}];
    [mapping addAttributeMappingsFromDictionary:@{@"mealDescription":@"mealDescription"}];
    [mapping addAttributeMappingsFromDictionary:@{@"name":@"name"}];
    [mapping addAttributeMappingsFromDictionary:@{@"protein":@"protein"}];
    [mapping addAttributeMappingsFromDictionary:@{@"servingSize":@"servingSize"}];
    [mapping addAttributeMappingsFromDictionary:@{@"totalFat":@"totalFat"}];
    [mapping addAttributeMappingsFromDictionary:@{@"weightWatchersPlusPoints":@"weightWatchersPlusPoints"}];
    [mapping addAttributeMappingsFromDictionary:@{@"whenEaten":@"whenEaten"}];
    [mapping addAttributeMappingsFromDictionary:@{@"objectId":@"objectId"}];
    return mapping;
}

@end
