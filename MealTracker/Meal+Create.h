//
//  Meal+Create.h
//  MealTracker
//
//  Created by Will Hindenburg on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MealCoreData.h"
#import "Meal.h"

@interface MealCoreData (Create)

+ (Meal *)mealForDictionaryInfo:(NSMutableDictionary *)mealDictionary;

+ (MealCoreData *)mealForDictionaryInfo:(NSMutableDictionary *)mealDictionary
       inManagedObjectContext:(NSManagedObjectContext *)context;

+ (MealCoreData *)updatedMealOldDictionaryInfo:(NSMutableDictionary *)oldMealDictionary withNewDictionaryInfo:(NSMutableDictionary *)newMealDictionary inManagedObjectContext:(NSManagedObjectContext *)context;

+ (NSMutableDictionary *)mutableMealDictionaryForMeal:(MealCoreData *)meal inManagedObjectContext:(NSManagedObjectContext *)context;

@end
