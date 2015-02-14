//
//  MealData.m
//  MealTracker
//
//  Created by William Hindenburg on 2/11/15.
//
//

#import "Meal.h"
#import "NSMutableDictionary+MealDictionary.h"

@implementation Meal

- (NSString *)className {
    return NSStringFromClass([self class]);
}

- (NSString *)objectType {
    return @"Pointer";
}

+ (Meal *)mealForDictionaryInfo:(NSMutableDictionary *)mealDictionary {
    Meal *meal = [Meal new];
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

@end
