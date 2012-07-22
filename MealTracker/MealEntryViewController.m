//
//  MealEntryViewController.m
//  MealTracker
//
//  Created by Will Hindenburg on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MealEntryViewController.h"
#import "NSMutableDictionary+MealDictionary.h"

@interface MealEntryViewController ()

@end

@implementation MealEntryViewController
@synthesize mealNameText;
@synthesize carbsText;
@synthesize dietaryFiberText;
@synthesize totalProteinText;
@synthesize servingSizeText;
@synthesize totalFatText;
@synthesize WWPointsText;
@synthesize mealDescriptionText;
@synthesize textEntryDelegate = _textEntryDelegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)doneButtonPressed:(UIBarButtonItem *)sender 
{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    dictionary.name = mealNameText.text;
    dictionary.description = mealDescriptionText.text;
    dictionary.carbs = [NSDecimalNumber decimalNumberWithString:carbsText.text];
    dictionary.dietaryFiber = [NSDecimalNumber decimalNumberWithString:dietaryFiberText.text];
    dictionary.protein = [NSDecimalNumber decimalNumberWithString:totalProteinText.text];
    dictionary.serving = servingSizeText.text;
    dictionary.totalFat = [NSDecimalNumber decimalNumberWithString:totalFatText.text];
    dictionary.points = [NSDecimalNumber decimalNumberWithString:WWPointsText.text];
    
    [self.textEntryDelegate viewController:self didFinishWithMealMutableDictionary:dictionary];
    [[self presentingViewController] dismissModalViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setCarbsText:nil];
    [self setDietaryFiberText:nil];
    [self setMealNameText:nil];
    [self setTotalProteinText:nil];
    [self setServingSizeText:nil];
    [self setTotalFatText:nil];
    [self setWWPointsText:nil];
    [self setMealDescriptionText:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
