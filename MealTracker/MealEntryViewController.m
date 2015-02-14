//
//  MealEntryViewController.m
//  MealTracker
//
//  Created by Will Hindenburg on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MealEntryViewController.h"
#import "Meal.h"

@interface MealEntryViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *mealNameText;
@property (weak, nonatomic) IBOutlet UITextField *carbsText;
@property (weak, nonatomic) IBOutlet UITextField *dietaryFiberText;
@property (weak, nonatomic) IBOutlet UITextField *totalProteinText;
@property (weak, nonatomic) IBOutlet UITextField *servingSizeText;
@property (weak, nonatomic) IBOutlet UITextField *totalFatText;
@property (weak, nonatomic) IBOutlet UITextField *WWPointsText;
@property (weak, nonatomic) IBOutlet UITextField *mealDescriptionText;

@property (nonatomic, strong) UITextField *activeField;
@end

@implementation MealEntryViewController

- (Meal *)mealData {
    if (_mealData == nil) {
        _mealData = [Meal new];
    }
    return _mealData;
}

- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender 
{
    NSString *mealName = self.mealNameText.text;
    [mealName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([mealName length] > 0)
    {
        self.mealData.name = self.mealNameText.text;
        self.mealData.mealDescription = self.mealDescriptionText.text;
        self.mealData.carbs = [NSDecimalNumber decimalNumberWithString:self.carbsText.text];
        self.mealData.dietaryFiber = [NSDecimalNumber decimalNumberWithString:self.dietaryFiberText.text];
        self.mealData.protein = [NSDecimalNumber decimalNumberWithString:self.totalProteinText.text];
        self.mealData.servingSize = self.servingSizeText.text;
        self.mealData.totalFat = [NSDecimalNumber decimalNumberWithString:self.totalFatText.text];
        self.mealData.weightWatchersPlusPoints = [NSDecimalNumber decimalNumberWithString:self.WWPointsText.text];
        
        if (self.mealData.objectId)
        {
            [self.textEntryDelegate viewController:self didFinishEditingMeal:self.mealData];
        }
        else 
        {
            [self.textEntryDelegate viewController:self didFinishWithMeal:self.mealData];
        }
        
        [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Meal Tracker" message:@"Please Enter a Meal Name" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
    }
}

- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender 
{
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
}
//pp = max {round((p x 16 + c x 19 + fa x 45)/175) - fi x (2/25), 0}, where pp is ProPoints, p is protein, c is carbohydrate, fa is total fat, and fi is dietary fiber, all in grams
- (NSDecimalNumber *)weightWatchersPointsForProtein:(NSDecimalNumber *)p 
                                      carbohydrates:(NSDecimalNumber *)c 
                                           totalFat:(NSDecimalNumber *)fa 
                                    andDietaryFiber:(NSDecimalNumber *)fi
{
    
    double pp = MAX(round(([p doubleValue] * 16 + [c doubleValue] * 19 + [fa doubleValue] * 45)/175) - [fi doubleValue] * (2/25), 0);
    NSDecimalNumber *num = [[NSDecimalNumber alloc] initWithDouble:pp];
    return num;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] 
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [tap setCancelsTouchesInView:NO];
    [self.view addGestureRecognizer:tap];
    
    self.mealNameText.delegate = self;
    self.carbsText.delegate = self;
    self.dietaryFiberText.delegate = self;
    self.totalProteinText.delegate = self;
    self.servingSizeText.delegate = self;
    self.totalFatText.delegate = self;
    self.WWPointsText.delegate = self;
    self.mealDescriptionText.delegate = self;
    
    self.mealNameText.text = @"";
    self.carbsText.text = @"";
    self.dietaryFiberText.text = @"";
    self.totalProteinText.text = @"";
    self.servingSizeText.text = @"";
    self.totalFatText.text = @"";
    self.WWPointsText.text = @"";
    self.mealDescriptionText.text = @"";
    
    if (self.mealData)
    {
        if (self.mealData.name) self.mealNameText.text = self.mealData.name;
        if (self.mealData.mealDescription) self.mealDescriptionText.text = self.mealData.mealDescription;
        if (self.mealData.servingSize) self.servingSizeText.text = self.mealData.servingSize;
        if ((self.mealData.carbs != nil) & [self.mealData.carbs compare:[NSDecimalNumber notANumber]])
        {
            self.carbsText.text = [self.mealData.carbs stringValue];
        }
        if ((self.mealData.dietaryFiber != nil) & ([self.mealData.dietaryFiber compare:[NSDecimalNumber notANumber]]))
        {
            self.dietaryFiberText.text = [self.mealData.dietaryFiber stringValue];
        }
        if ((self.mealData.protein != nil) & ([self.mealData.protein compare:[NSDecimalNumber notANumber]]))
        {
            self.totalProteinText.text = [self.mealData.protein stringValue];
        }
        if ((self.mealData.totalFat != nil) & ([self.mealData.totalFat compare:[NSDecimalNumber notANumber]]))
        {
            self.totalFatText.text = [self.mealData.totalFat stringValue];
        }
        if ((self.mealData.weightWatchersPlusPoints != nil) & ([self.mealData.weightWatchersPlusPoints compare:[NSDecimalNumber notANumber]]))
        {
            self.WWPointsText.text = [self.mealData.weightWatchersPlusPoints stringValue];
        }
    }
    
}

-(void)dismissKeyboard {
    [self.mealNameText resignFirstResponder];
    [self.carbsText resignFirstResponder];
    [self.dietaryFiberText resignFirstResponder];
    [self.totalProteinText resignFirstResponder];
    [self.servingSizeText resignFirstResponder];
    [self.totalFatText resignFirstResponder];
    [self.WWPointsText resignFirstResponder];
    [self.mealDescriptionText resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.activeField = textField;
    
}



- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.activeField = nil;
    if (([self.totalProteinText.text length] > 0) & ([self.carbsText.text length] > 0) & ([self.totalFatText.text length] > 0) & ([self.dietaryFiberText.text length] > 0))
    {
        NSDecimalNumber *wwPoints = [self weightWatchersPointsForProtein:[NSDecimalNumber decimalNumberWithString:self.totalProteinText.text]
                                                           carbohydrates:[NSDecimalNumber decimalNumberWithString:self.carbsText.text]
                                                                totalFat:[NSDecimalNumber decimalNumberWithString:self.totalFatText.text]
                                                         andDietaryFiber:[NSDecimalNumber decimalNumberWithString:self.dietaryFiberText.text]];
        self.WWPointsText.text = [wwPoints stringValue]; 
    }
    
}

@end
