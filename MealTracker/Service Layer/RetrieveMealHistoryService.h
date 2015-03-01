//
//  RetrieveMealHistoryService.h
//  MealTracker
//
//  Created by William Hindenburg on 2/14/15.
//
//

#import <BaseClasses/BaseService.h>

@class User;

@interface RetrieveMealHistoryService : BaseService <Service>
- (void)loadMealHistoryBasedOnUser:(User *)user withSuccessBlock:(void (^)(NSArray * data))successBlock andError:(void (^)(NSError *error))errorBlock;
@end
