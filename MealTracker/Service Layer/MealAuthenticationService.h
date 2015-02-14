//
//  MealAuthenticationService.h
//  MealTracker
//
//  Created by William Hindenburg on 2/11/15.
//
//

#import "BaseMealService.h"

@class User;

@interface MealAuthenticationService : BaseMealService <MealService>
- (void)registerUser:(User *)user withSuccessBlock:(void (^)(User *user))successBlock andError:(void (^)(NSError *error))errorBlock;
- (void)loginUser:(User *)user withSuccessBlock:(void (^)(User *user))successBlock andError:(void (^)(NSError *error))errorBlock;
@end
