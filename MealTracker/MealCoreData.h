//
//  Meal.h
//  MealTracker
//
//  Created by William Hindenburg on 7/25/12.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DateEaten;

@interface MealCoreData : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * calories;
@property (nonatomic, retain) NSDecimalNumber * carbs;
@property (nonatomic, retain) NSDecimalNumber * dietaryFiber;
@property (nonatomic, retain) NSString * mealDescription;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDecimalNumber * protein;
@property (nonatomic, retain) NSString * servingSize;
@property (nonatomic, retain) NSDecimalNumber * totalFat;
@property (nonatomic, retain) NSDecimalNumber * weightWatchersPlusPoints;
@property (nonatomic, retain) NSSet *whenEaten;
@end

@interface MealCoreData (CoreDataGeneratedAccessors)

- (void)addWhenEatenObject:(DateEaten *)value;
- (void)removeWhenEatenObject:(DateEaten *)value;
- (void)addWhenEaten:(NSSet *)values;
- (void)removeWhenEaten:(NSSet *)values;

@end
