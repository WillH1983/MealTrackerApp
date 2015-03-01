//
//  DeleteMealEaten.h
//  MealTracker
//
//  Created by William Hindenburg on 2/15/15.
//
//

#import <BaseClassesSDK/BaseService.h>

@class MealEaten;

@interface DeleteMealEatenService : BaseService <Service>
- (void)removeMealsEaten:(NSArray *)mealsEaten withSuccessBlock:(void (^)())successBlock andError:(void (^)(NSError *error))errorBlock;
- (void)removeMealEaten:(MealEaten *)meal withSuccessBlock:(void (^)())successBlock andError:(void (^)(NSError *error))errorBlock;
@end
