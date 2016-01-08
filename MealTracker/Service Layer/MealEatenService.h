//
//  MealEatenService.h
//  MealTracker
//
//  Created by William Hindenburg on 2/13/15.
//
//

#import "BaseService.h"

@class MealEaten;

@interface MealEatenService : BaseService //<Service>
- (void)saveMealEaten:(MealEaten *)mealEaten withSuccessBlock:(void (^)(MealEaten *mealEaten))successBlock andError:(void (^)(NSError *error))errorBlock;
@end
