//
//  UserService.h
//  MealTracker
//
//  Created by William Hindenburg on 2/17/15.
//
//

#import <BaseClasses/BaseClasses.h>

@class User;

@interface UserService : BaseService <Service>
- (void)updateUser:(User *)user withSuccessBlock:(void (^)(User *user))successBlock andError:(void (^)(NSError *error))errorBlock;
@end
