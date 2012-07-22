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
@property (nonatomic, strong) UITextField *activeField;
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
@synthesize scrollView;
@synthesize activeField = _activeField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender 
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

- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender 
{
   [[self presentingViewController] dismissModalViewControllerAnimated:YES]; 
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
    
    [self registerForKeyboardNotifications];
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
    [self setScrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

// Call this method somewhere in your view controller setup code.

- (void)registerForKeyboardNotifications

{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
     
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillBeHidden:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    
    
}

// Called when the UIKeyboardDidShowNotification is sent.

- (void)keyboardWasShown:(NSNotification*)aNotification

{
    
    NSDictionary* info = [aNotification userInfo];
    
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    
    self.scrollView.contentInset = contentInsets;
    
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    
    // Your application might not need or want this behavior.
    
    CGRect aRect = self.view.frame;
    
    aRect.size.height -= kbSize.height;
    NSLog(@"%@", self.activeField.frame.origin.x);
    
    if (!CGRectContainsPoint(aRect, self.activeField.frame.origin) ) {
        
        CGPoint scrollPoint = CGPointMake(0.0, self.activeField.frame.origin.y-kbSize.height);
        
        [self.scrollView setContentOffset:scrollPoint animated:YES];
        
    }
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField

{
    
    self.activeField = textField;
    
}



- (void)textFieldDidEndEditing:(UITextField *)textField

{
    
    self.activeField = nil;
    
}



// Called when the UIKeyboardWillHideNotification is sent

- (void)keyboardWillBeHidden:(NSNotification*)aNotification

{
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    
    scrollView.contentInset = contentInsets;
    
    scrollView.scrollIndicatorInsets = contentInsets;
    
}

@end
