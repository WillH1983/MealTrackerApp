//
//  SavePrivateMessageService.h
//  Life
//
//  Created by William Hindenburg on 1/14/15.
//  Copyright (c) 2015 William Hindenburg. All rights reserved.
//

#import "BaseMealService.h"

@class MealData;

@interface SaveMealService : BaseMealService <MealService>
- (void)updateMeal:(MealData *)meal withSuccessBlock:(void (^)())successBlock andError:(void (^)(NSError *error))errorBlock;
- (void)saveMeal:(MealData *)meal withSuccessBlock:(void (^)())successBlock andError:(void (^)(NSError *error))errorBlock;
@end
