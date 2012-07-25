//
//  DateEaten.h
//  MealTracker
//
//  Created by William Hindenburg on 7/25/12.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Meal;

@interface DateEaten : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) Meal *whatWasEaten;

@end
