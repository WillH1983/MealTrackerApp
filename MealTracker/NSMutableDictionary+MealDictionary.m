//
//  NSDictionary+MealDictionary.m
//  MealTracker
//
//  Created by Will Hindenburg on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSMutableDictionary+MealDictionary.h"

@implementation NSMutableDictionary (MealDictionary)

- (void)setName:(NSString *)name
{
    [self setObject:name forKey:@"name"]; 
}

- (NSString *)name
{
    return [self objectForKey:@"name"];
}

- (void)setDescription:(NSString *)description
{
    [self setObject:description forKey:@"description"]; 
}

- (NSString *)description
{
    return [self objectForKey:@"description"];
}

- (void)setCarbs:(NSDecimalNumber *)carbs
{
    [self setObject:carbs forKey:@"carbs"];
}

- (NSDecimalNumber *)carbs
{
    return [self objectForKey:@"carbs"];
}

- (void)setDietaryFiber:(NSDecimalNumber *)dietaryFiber
{
    [self setObject:dietaryFiber forKey:@"dietaryFiber"];
}

- (NSDecimalNumber *)dietaryFiber
{
    return [self objectForKey:@"dietaryFiber"];
}

- (void)setProtein:(NSDecimalNumber *)protein
{
    [self setObject:protein forKey:@"protein"];
}

- (NSDecimalNumber *)protein
{
    return [self objectForKey:@"protein"];
}

- (void)setServing:(NSString *)serving
{
    [self setObject:serving forKey:@"serving"];
}

- (NSString *)serving
{
    return [self objectForKey:@"serving"];
}

- (void)setTotalFat:(NSDecimalNumber *)totalFat
{
    [self setObject:totalFat forKey:@"totalFat"];
}

- (NSDecimalNumber *)totalFat
{
    return [self objectForKey:@"totalFat"];
}

- (void)setPoints:(NSDecimalNumber *)points
{
    [self setObject:points forKey:@"points"];
}

- (NSDecimalNumber *)points
{
    return [self objectForKey:@"points"];
}

+ (NSDictionary *)mealWithName:(NSString *)name 
                    totalCarbs:(NSDecimalNumber *)carbs 
             totalDietaryFiber:(NSDecimalNumber *)dietaryFiber 
               mealDescription:(NSString *)description 
                  totalProtein:(NSDecimalNumber *)protein 
                   servingSize:(NSString *)serving 
                      totalFat:(NSDecimalNumber *)fat 
                  WWPlusPoints:(NSDecimalNumber *)points
{
    return nil;
}



@end
