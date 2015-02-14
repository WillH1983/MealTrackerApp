//
//  User.m
//  MealTracker
//
//  Created by William Hindenburg on 2/11/15.
//
//

#import "User.h"

@implementation User

+ (User *)userObjectFromDictionary:(NSDictionary *)dictionary {
    User *user = [User new];
    user.username = [dictionary objectForKey:@"username"];
    user.objectId = [dictionary objectForKey:@"objectId"];
    user.sessionToken = [dictionary objectForKey:@"sessionToken"];
    return user;
}

- (NSDictionary *)dictionaryRepresentation {
    return [NSDictionary dictionaryWithObjectsAndKeys:self.username, @"username", self.objectId, @"objectId", self.sessionToken, @"sessionToken", nil];
}

@end
