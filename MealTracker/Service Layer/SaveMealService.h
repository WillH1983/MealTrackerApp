//
//  SavePrivateMessageService.h
//  Life
//
//  Created by William Hindenburg on 1/14/15.
//  Copyright (c) 2015 William Hindenburg. All rights reserved.
//

#import "BaseService.h"

@class Meal;

@interface SaveMealService : BaseService //<Service>
- (void)updateMeal:(Meal *)meal withSuccessBlock:(void (^)())successBlock andError:(void (^)(NSError *error))errorBlock;
- (void)saveMeal:(Meal *)meal withSuccessBlock:(void (^)(Meal *meal))successBlock andError:(void (^)(NSError *error))errorBlock;
@end
