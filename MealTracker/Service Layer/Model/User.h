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

+ (User *)userObjectFromDictionary:(NSDictionary *)dictionary;

- (NSDictionary *)dictionaryRepresentation;
@end
