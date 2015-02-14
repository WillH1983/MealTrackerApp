//
//  MealEntryViewController.h
//  MealTracker
//
//  Created by Will Hindenburg on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Meal;

@protocol MealTextEntryDelegate <NSObject>
- (void)viewController:(id)sender didFinishWithMeal:(Meal *)meal;
- (void)viewController:(id)sender didFinishEditingMeal:(Meal *)meal;
@end

@interface MealEntryViewController : UITableViewController


@property (nonatomic, weak) id <MealTextEntryDelegate> textEntryDelegate;

@property (nonatomic, strong) Meal *mealData;

@end
