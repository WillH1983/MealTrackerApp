//
//  MealEaten.h
//  MealTracker
//
//  Created by William Hindenburg on 2/13/15.
//
//

#import <Foundation/Foundation.h>

@class Meal;
@class User;

@interface MealEaten : NSObject
@property (strong, nonatomic) NSDate *dateEaten;
@property (strong, nonatomic) User *user;
@property (strong, nonatomic) Meal *meal;
@property (strong, nonatomic) NSString *objectId;
@property (strong, nonatomic) NSString *method;
@property (strong, nonatomic) NSString *path;
@end
