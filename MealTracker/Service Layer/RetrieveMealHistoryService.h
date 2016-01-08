//
//  RetrieveMealHistoryService.h
//  MealTracker
//
//  Created by William Hindenburg on 2/14/15.
//
//

#import "BaseService.h"

NS_ASSUME_NONNULL_BEGIN

@class User;

@interface RetrieveMealHistoryService : BaseService //<Service>
//<Dictionary<String, AnyObject>>
- (void)loadMealHistoryBasedOnUser:(User *)user withSuccessBlock:(void (^)(NSArray <NSDictionary<NSString *, id> *> *data))successBlock andError:(void (^)(NSError *error))errorBlock;
@end

NS_ASSUME_NONNULL_END
