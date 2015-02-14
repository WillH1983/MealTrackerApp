//
//  RetrieveMealHistoryService.h
//  MealTracker
//
//  Created by William Hindenburg on 2/14/15.
//
//

#import "BaseMealService.h"

@class User;

@interface RetrieveMealHistoryService : BaseMealService <MealService>
- (void)loadMealHistoryBasedOnUser:(User *)user withSuccessBlock:(void (^)(NSArray * data))successBlock andError:(void (^)(NSError *error))errorBlock;
@end
