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

@interface MealEntryViewController : UITableViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *mealNameText;
@property (weak, nonatomic) IBOutlet UITextField *carbsText;
@property (weak, nonatomic) IBOutlet UITextField *dietaryFiberText;
@property (weak, nonatomic) IBOutlet UITextField *totalProteinText;
@property (weak, nonatomic) IBOutlet UITextField *servingSizeText;
@property (weak, nonatomic) IBOutlet UITextField *totalFatText;
@property (weak, nonatomic) IBOutlet UITextField *WWPointsText;
@property (weak, nonatomic) IBOutlet UITextField *mealDescriptionText;

@property (nonatomic, weak) id <MealTextEntryDelegate> textEntryDelegate;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) Meal *mealData;

@end
