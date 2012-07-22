//
//  Meal+Create.h
//  MealTracker
//
//  Created by Will Hindenburg on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Meal.h"

@interface Meal (Create)

+ (Meal *)mealWithName:(NSString *)name 
            totalCarbs:(NSDecimalNumber *)carbs 
     totalDietaryFiber:(NSDecimalNumber *)dietaryFiber 
       mealDescription:(NSString *)description 
          totalProtein:(NSDecimalNumber *)protein 
           servingSize:(NSString *)serving 
              totalFat:(NSDecimalNumber *)fat 
          WWPlusPoints:(NSDecimalNumber *)points
inManagedObjectContext:(NSManagedObjectContext *)context;

+ (Meal *)mealForDictionaryInfo:(NSDictionary *)mealDictionary
       inManagedObjectContext:(NSManagedObjectContext *)context;

@end
