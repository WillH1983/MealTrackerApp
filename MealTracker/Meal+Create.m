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

+ (NSMutableDictionary *)mutableMealDictionaryForMeal:(Meal *)meal inManagedObjectContext:(NSManagedObjectContext *)context
{
    NSMutableDictionary *mealDictionary = [[NSMutableDictionary alloc] init];
    mealDictionary.name = meal.name;
    mealDictionary.carbs = meal.carbs;
    mealDictionary.dietaryFiber = meal.dietaryFiber;
    mealDictionary.description = meal.mealDescription;
    mealDictionary.protein = meal.protein;
    mealDictionary.serving = meal.servingSize;
    mealDictionary.totalFat = meal.totalFat;
    mealDictionary.points = meal.weightWatchersPlusPoints;
    
    return mealDictionary;
}

+ (MealData *)mealForDictionaryInfo:(NSMutableDictionary *)mealDictionary {
    MealData *meal = [MealData new];
    meal.name = mealDictionary.name;
    meal.carbs = mealDictionary.carbs;
    meal.dietaryFiber = mealDictionary.dietaryFiber;
    meal.mealDescription = mealDictionary.description;
    meal.protein = mealDictionary.protein;
    meal.servingSize = mealDictionary.serving;
    meal.totalFat = mealDictionary.totalFat;
    meal.weightWatchersPlusPoints = mealDictionary.points;
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
    
    if (![matches count])
    {
        meal = [NSEntityDescription insertNewObjectForEntityForName:@"Meal" inManagedObjectContext:context];
    }
    else
    {
        meal = [matches lastObject];
    }
    
    meal.name = mealDictionary.name;
    meal.carbs = mealDictionary.carbs;
    meal.dietaryFiber = mealDictionary.dietaryFiber;
    meal.mealDescription = mealDictionary.description;
    meal.protein = mealDictionary.protein;
    meal.servingSize = mealDictionary.serving;
    meal.totalFat = mealDictionary.totalFat;
    meal.weightWatchersPlusPoints = mealDictionary.points;
    
    return meal;
}

+ (Meal *)updatedMealOldDictionaryInfo:(NSMutableDictionary *)oldMealDictionary withNewDictionaryInfo:(NSMutableDictionary *)newMealDictionary inManagedObjectContext:(NSManagedObjectContext *)context
{
    Meal *meal = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Meal"];
    request.predicate = [NSPredicate predicateWithFormat:@"name = %@", oldMealDictionary.name];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error = nil;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if (![matches count])
    {
        meal = [NSEntityDescription insertNewObjectForEntityForName:@"Meal" inManagedObjectContext:context];
    }
    else
    {
        meal = [matches lastObject];
    }
    
    meal.name = newMealDictionary.name;
    meal.carbs = newMealDictionary.carbs;
    meal.dietaryFiber = newMealDictionary.dietaryFiber;
    meal.mealDescription = newMealDictionary.description;
    meal.protein = newMealDictionary.protein;
    meal.servingSize = newMealDictionary.serving;
    meal.totalFat = newMealDictionary.totalFat;
    meal.weightWatchersPlusPoints = newMealDictionary.points;
    
    return meal;
}


@end
