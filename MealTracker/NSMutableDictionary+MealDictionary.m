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
    if (![self objectForKey:@"name"]) self.name = @"";
    return [self objectForKey:@"name"];
}

- (void)setDescription:(NSString *)description
{
    [self setObject:description forKey:@"description"]; 
}

- (NSString *)description
{
    if (![self objectForKey:@"description"]) self.description = @"";
    return [self objectForKey:@"description"];
}

- (void)setCarbs:(NSDecimalNumber *)carbs
{
    [self setObject:carbs forKey:@"carbs"];
}

- (NSDecimalNumber *)carbs
{
    if (![self objectForKey:@"carbs"]) self.carbs = [NSDecimalNumber notANumber];
    return [self objectForKey:@"carbs"];
}

- (void)setDietaryFiber:(NSDecimalNumber *)dietaryFiber
{
    [self setObject:dietaryFiber forKey:@"dietaryFiber"];
}

- (NSDecimalNumber *)dietaryFiber
{
    if (![self objectForKey:@"dietaryFiber"]) self.dietaryFiber = [NSDecimalNumber notANumber];
    return [self objectForKey:@"dietaryFiber"];
}

- (void)setProtein:(NSDecimalNumber *)protein
{
    [self setObject:protein forKey:@"protein"];
}

- (NSDecimalNumber *)protein
{
    if (![self objectForKey:@"protein"]) self.protein = [NSDecimalNumber notANumber];
    return [self objectForKey:@"protein"];
}

- (void)setServing:(NSString *)serving
{
    [self setObject:serving forKey:@"serving"];
}

- (NSString *)serving
{
    if (![self objectForKey:@"serving"]) self.serving = @"";
    return [self objectForKey:@"serving"];
}

- (void)setTotalFat:(NSDecimalNumber *)totalFat
{
    [self setObject:totalFat forKey:@"totalFat"];
}

- (NSDecimalNumber *)totalFat
{
    if (![self objectForKey:@"totalFat"]) self.totalFat = [NSDecimalNumber notANumber];
    return [self objectForKey:@"totalFat"];
}

- (void)setPoints:(NSDecimalNumber *)points
{
    [self setObject:points forKey:@"points"];
}

- (NSDecimalNumber *)points
{
    if (![self objectForKey:@"points"]) self.points = [NSDecimalNumber notANumber];
    return [self objectForKey:@"points"];
}

@end
