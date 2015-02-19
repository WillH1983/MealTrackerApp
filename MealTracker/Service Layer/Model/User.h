//
//  User.h
//  MealTracker
//
//  Created by William Hindenburg on 2/11/15.
//
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *objectId;
@property (nonatomic, strong) NSString *sessionToken;
@property (strong, nonatomic) NSString *className;
@property (strong, nonatomic) NSString *objectType;
@property (assign, nonatomic) NSNumber *pointsPerWeek;

+ (User *)persistentUserObject;
+ (void)deleteUser;

- (void)save;


@end
