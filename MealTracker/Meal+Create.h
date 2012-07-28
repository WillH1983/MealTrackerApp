//
//  Meal+Create.h
//  MealTracker
//
//  Created by Will Hindenburg on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Meal.h"

@interface Meal (Create)

+ (Meal *)mealForDictionaryInfo:(NSMutableDictionary *)mealDictionary
       inManagedObjectContext:(NSManagedObjectContext *)context;

+ (Meal *)updatedMealOldDictionaryInfo:(NSMutableDictionary *)oldMealDictionary withNewDictionaryInfo:(NSMutableDictionary *)newMealDictionary inManagedObjectContext:(NSManagedObjectContext *)context;

+ (NSMutableDictionary *)mutableMealDictionaryForMeal:(Meal *)meal inManagedObjectContext:(NSManagedObjectContext *)context;

@end
