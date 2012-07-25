//
//  DateEaten+Create.h
//  MealTracker
//
//  Created by William Hindenburg on 7/25/12.
//
//

#import "DateEaten.h"

@interface DateEaten (Create)
+ (DateEaten *)dailyMealsinManagedObjectContext:(NSManagedObjectContext *)context;
@end
