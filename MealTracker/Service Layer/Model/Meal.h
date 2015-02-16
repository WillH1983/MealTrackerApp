//
//  MealData.h
//  MealTracker
//
//  Created by William Hindenburg on 2/11/15.
//
//

#import <Foundation/Foundation.h>

@interface Meal : NSObject
@property (nonatomic, strong) NSDecimalNumber *calories;
@property (nonatomic, strong) NSDecimalNumber *carbs;
@property (nonatomic, strong) NSDecimalNumber *dietaryFiber;
@property (nonatomic, strong) NSString *mealDescription;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSDecimalNumber *protein;
@property (nonatomic, strong) NSString *servingSize;
@property (nonatomic, strong) NSDecimalNumber *totalFat;
@property (nonatomic, strong) NSDecimalNumber *weightWatchersPlusPoints;
@property (nonatomic, strong) NSSet *whenEaten;
@property (nonatomic, strong) NSString *objectId;
@property (strong, nonatomic) NSString *className;
@property (strong, nonatomic) NSString *objectType;
@property (strong, nonatomic) NSString *method;
@property (strong, nonatomic) NSString *path;

@end
