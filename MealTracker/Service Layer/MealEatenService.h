//
//  MealEatenService.h
//  MealTracker
//
//  Created by William Hindenburg on 2/13/15.
//
//

#import "BaseMealService.h"

@class MealEaten;

@interface MealEatenService : BaseMealService <Service>
- (void)saveMealEaten:(MealEaten *)mealEaten withSuccessBlock:(void (^)(MealEaten *mealEaten))successBlock andError:(void (^)(NSError *error))errorBlock;
@end
