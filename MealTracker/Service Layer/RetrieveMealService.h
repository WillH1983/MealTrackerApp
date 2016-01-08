//
//  RetrieveMealService.h
//  MealTracker
//
//  Created by William Hindenburg on 2/12/15.
//
//

#import "BaseService.h"

@class Meal;

@interface RetrieveMealService : BaseService //<Service>
- (void)retrieveMealsWithSuccessBlock:(void (^)(NSArray<Meal *> *meals))successBlock andError:(void (^)(NSError *error))errorBlock;
@end
