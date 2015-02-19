//
//  User.m
//  MealTracker
//
//  Created by William Hindenburg on 2/11/15.
//
//

#import "User.h"

@implementation User
@synthesize pointsPerWeek;

+ (User *)userObjectFromDictionary:(NSDictionary *)dictionary {
    User *user = [User new];
    user.username = [dictionary objectForKey:@"username"];
    user.objectId = [dictionary objectForKey:@"objectId"];
    user.sessionToken = [dictionary objectForKey:@"sessionToken"];
    user.pointsPerWeek = [dictionary objectForKey:@"pointsPerWeek"];
    return user;
}

+ (User *)persistentUserObject {
    NSDictionary *userDictionary = [[NSUserDefaults standardUserDefaults] objectForKey:@"userData"];
    return [User userObjectFromDictionary:userDictionary];
}

+ (void)deleteUser {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"userData"];
    [userDefaults synchronize];
}

- (NSDictionary *)dictionaryRepresentation {
    return [NSDictionary dictionaryWithObjectsAndKeys:self.username, @"username", self.objectId, @"objectId", self.sessionToken, @"sessionToken", self.pointsPerWeek, @"pointsPerWeek", nil];
}

- (NSString *)className {
    return @"_User";
}

- (NSString *)objectType {
    return @"Pointer";
}

- (void)save {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[self dictionaryRepresentation] forKey:@"userData"];
    [userDefaults synchronize];
}

@end
