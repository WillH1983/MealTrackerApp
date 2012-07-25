//
//  NSDictionary+MealDictionary.h
//  MealTracker
//
//  Created by Will Hindenburg on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//



@interface NSMutableDictionary (MealDictionary)

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSDecimalNumber *carbs;
@property (nonatomic, strong) NSDecimalNumber *dietaryFiber;
@property (nonatomic, strong) NSDecimalNumber *protein;
@property (nonatomic, strong) NSString *serving;
@property (nonatomic, strong) NSDecimalNumber *totalFat;
@property (nonatomic, strong) NSDecimalNumber *points;

@end
