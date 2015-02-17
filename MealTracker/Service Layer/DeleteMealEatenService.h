//
//  DeleteMealEaten.h
//  MealTracker
//
//  Created by William Hindenburg on 2/15/15.
//
//

#import "BaseMealService.h"

@class MealEaten;

@interface DeleteMealEatenService : BaseMealService <MealService>
- (void)removeMealsEaten:(NSArray *)mealsEaten withSuccessBlock:(void (^)())successBlock andError:(void (^)(NSError *error))errorBlock;
- (void)removeMealEaten:(MealEaten *)meal withSuccessBlock:(void (^)())successBlock andError:(void (^)(NSError *error))errorBlock;
@end
