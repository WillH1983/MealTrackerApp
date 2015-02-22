//
//  UserService.h
//  MealTracker
//
//  Created by William Hindenburg on 2/17/15.
//
//

#import "BaseMealService.h"

@class User;

@interface UserService : BaseMealService <Service>
- (void)updateUser:(User *)user withSuccessBlock:(void (^)(User *user))successBlock andError:(void (^)(NSError *error))errorBlock;
@end
