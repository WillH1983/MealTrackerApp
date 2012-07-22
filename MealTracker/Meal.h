//
//  Meal.h
//  MealTracker
//
//  Created by Will Hindenburg on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Meal : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * calories;
@property (nonatomic, retain) NSDecimalNumber * carbs;
@property (nonatomic, retain) NSDecimalNumber * dietaryFiber;
@property (nonatomic, retain) NSString * mealDescription;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDecimalNumber * protein;
@property (nonatomic, retain) NSString * servingSize;
@property (nonatomic, retain) NSDecimalNumber * totalFat;
@property (nonatomic, retain) NSDecimalNumber * weightWatchersPlusPoints;

@end
