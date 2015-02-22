//
//  DeleteMealService.h
//  MealTracker
//
//  Created by William Hindenburg on 2/15/15.
//
//

#import "BaseMealService.h"

@class Meal;

@interface DeleteMealService : BaseMealService <Service>
- (void)removeMeals:(NSArray *)meals withSuccessBlock:(void (^)())successBlock andError:(void (^)(NSError *error))errorBlock;
- (void)removeMeal:(Meal *)meal withSuccessBlock:(void (^)())successBlock andError:(void (^)(NSError *error))errorBlock;
@end
