//
//  Meal+Create.m
//  MealTracker
//
//  Created by Will Hindenburg on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Meal+Create.h"
#import "NSMutableDictionary+MealDictionary.h"

@implementation MealCoreData (Create)

+ (NSMutableDictionary *)mutableMealDictionaryForMeal:(MealCoreData *)meal inManagedObjectContext:(NSManagedObjectContext *)context
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


+ (MealCoreData *)mealForDictionaryInfo:(NSMutableDictionary *)mealDictionary
         inManagedObjectContext:(NSManagedObjectContext *)context
{
    MealCoreData *meal = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"MealCoreData"];
    request.predicate = [NSPredicate predicateWithFormat:@"name = %@", mealDictionary.name];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error = nil;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if (![matches count])
    {
        meal = [NSEntityDescription insertNewObjectForEntityForName:@"MealCoreData" inManagedObjectContext:context];
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

+ (MealCoreData *)updatedMealOldDictionaryInfo:(NSMutableDictionary *)oldMealDictionary withNewDictionaryInfo:(NSMutableDictionary *)newMealDictionary inManagedObjectContext:(NSManagedObjectContext *)context
{
    MealCoreData *meal = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"MealCoreData"];
    request.predicate = [NSPredicate predicateWithFormat:@"name = %@", oldMealDictionary.name];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error = nil;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if (![matches count])
    {
        meal = [NSEntityDescription insertNewObjectForEntityForName:@"MealCoreData" inManagedObjectContext:context];
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
