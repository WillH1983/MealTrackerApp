//
//  MealEaten.h
//  MealTracker
//
//  Created by William Hindenburg on 2/13/15.
//
//

#import <Foundation/Foundation.h>

@class MealData;
@class User;

@interface MealEaten : NSObject
@property (strong, nonatomic) NSDate *dateEaten;
@property (strong, nonatomic) MealData *mealEaten;
@property (strong, nonatomic) User *user;
@property (strong, nonatomic) NSString *className;
@property (strong, nonatomic) NSString *objectType;
@end
