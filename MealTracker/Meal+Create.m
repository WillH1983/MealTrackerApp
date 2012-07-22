//
//  Meal+Create.m
//  MealTracker
//
//  Created by Will Hindenburg on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Meal+Create.h"
#import "NSMutableDictionary+MealDictionary.h"

@implementation Meal (Create)

+ (Meal *)mealWithName:(NSString *)name 
            totalCarbs:(NSDecimalNumber *)carbs 
     totalDietaryFiber:(NSDecimalNumber *)dietaryFiber 
       mealDescription:(NSString *)description 
          totalProtein:(NSDecimalNumber *)protein 
           servingSize:(NSString *)serving 
              totalFat:(NSDecimalNumber *)fat 
          WWPlusPoints:(NSDecimalNumber *)points
inManagedObjectContext:(NSManagedObjectContext *)context
{
    Meal *meal = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Meal"];
    request.predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error = nil;
    NSArray *photographers = [context executeFetchRequest:request error:&error];
    
    if (!photographers || ([photographers count] > 1)) {
        // handle error
    } else {
        meal = [NSEntityDescription insertNewObjectForEntityForName:@"Meal"
                                                     inManagedObjectContext:context];
        meal.name = name;
        meal.carbs = carbs;
        meal.dietaryFiber = dietaryFiber;
        meal.mealDescription = description;
        meal.protein = protein;
        meal.servingSize = serving;
        meal.totalFat = fat;
        meal.weightWatchersPlusPoints = points;
    } 
    
    return meal;
}

+ (Meal *)mealForDictionaryInfo:(NSMutableDictionary *)mealDictionary
         inManagedObjectContext:(NSManagedObjectContext *)context
{
    Meal *meal = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Meal"];
    request.predicate = [NSPredicate predicateWithFormat:@"name = %@", mealDictionary.name];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error = nil;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if (!matches || ([matches count] > 1)) {
        // handle error
    } else {
        meal = [NSEntityDescription insertNewObjectForEntityForName:@"Meal" inManagedObjectContext:context];
        meal.name = mealDictionary.name;
        meal.carbs = mealDictionary.carbs;
        meal.dietaryFiber = mealDictionary.dietaryFiber;
        meal.mealDescription = mealDictionary.description;
        meal.protein = mealDictionary.protein;
        meal.servingSize = mealDictionary.serving;
        meal.totalFat = mealDictionary.totalFat;
        meal.weightWatchersPlusPoints = mealDictionary.points;
    }
    
    return meal;
}

@end
