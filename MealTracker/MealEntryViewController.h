//
//  MealEntryViewController.h
//  MealTracker
//
//  Created by Will Hindenburg on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MealTextEntryDelegate <NSObject>
- (void)viewController:(id)sender didFinishWithMealMutableDictionary:(NSMutableDictionary *)dictionary;
@end

@interface MealEntryViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *mealNameText;
@property (weak, nonatomic) IBOutlet UITextField *carbsText;
@property (weak, nonatomic) IBOutlet UITextField *dietaryFiberText;
@property (weak, nonatomic) IBOutlet UITextField *totalProteinText;
@property (weak, nonatomic) IBOutlet UITextField *servingSizeText;
@property (weak, nonatomic) IBOutlet UITextField *totalFatText;
@property (weak, nonatomic) IBOutlet UITextField *WWPointsText;
@property (weak, nonatomic) IBOutlet UITextField *mealDescriptionText;

@property (nonatomic, weak) id <MealTextEntryDelegate> textEntryDelegate;

@end
