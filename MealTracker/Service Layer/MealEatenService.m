//
//  MealEatenService.m
//  MealTracker
//
//  Created by William Hindenburg on 2/13/15.
//
//

#import "MealEatenService.h"
#import "Meal.h"
#import "MealTracker-Swift.h"

@import BaseClassesSwift;

@implementation MealEatenService

- (void)saveMealEaten:(MealEaten *)mealEaten withSuccessBlock:(void (^)(MealEaten *mealEaten))successBlock andError:(void (^)(NSError *error))errorBlock {
    
//    ServiceClient *serviceClient = [ServiceClient new];
//    [serviceClient postObject:mealEaten andService:self withSuccessBlock:^(RKMappingResult *result) {
//        successBlock(result.firstObject);
//    } andError:^(NSError *error) {
//        errorBlock(error);
//    }];
}

- (NSString *)serviceURL {
    return [NSString stringWithFormat:@"/1/classes/%@", NSStringFromClass([MealEaten class])];
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

//- (RKObjectMapping *)mappingProvider {
//    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[MealEaten class]];
//    [mapping addAttributeMappingsFromDictionary:@{@"objectId":@"objectId"}];
//    return mapping;
//}
//
//- (RKObjectMapping *)serializedMappingProvider {
//    RKObjectMapping *seriallMapping = [RKObjectMapping mappingForClass:[MealEaten class]];
//    [seriallMapping addAttributeMappingsFromDictionary:@{@"dateEaten":@"dateEaten"}];
//    
//    RKObjectMapping *userPointerMapping = [RKObjectMapping mappingForClass:[User class]];
//    [userPointerMapping addAttributeMappingsFromDictionary:@{@"__type":@"objectType"}];
//    [userPointerMapping addAttributeMappingsFromDictionary:@{@"objectId": @"objectId"}];
//    [userPointerMapping addAttributeMappingsFromDictionary:@{@"className": @"className"}];
//    RKRelationshipMapping *userPointerRelationshipMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"user" toKeyPath:@"user" withMapping:userPointerMapping];
//    [seriallMapping addPropertyMapping:userPointerRelationshipMapping];
//    
//    RKObjectMapping *mealMapping = [RKObjectMapping mappingForClass:[Meal class]];
//    [mealMapping addAttributeMappingsFromDictionary:@{@"__type":@"objectType"}];
//    [mealMapping addAttributeMappingsFromDictionary:@{@"objectId": @"objectId"}];
//    [mealMapping addAttributeMappingsFromDictionary:@{@"className": @"className"}];
//    RKRelationshipMapping *mealPointerRelationshipMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"meal" toKeyPath:@"meal" withMapping:userPointerMapping];
//    [seriallMapping addPropertyMapping:mealPointerRelationshipMapping];
//    
//    return seriallMapping;
//}

@end
