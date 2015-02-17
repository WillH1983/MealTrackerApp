//
//  UserSettingsViewController.m
//  MealTracker
//
//  Created by William Hindenburg on 2/17/15.
//
//

#import "UserSettingsViewController.h"

@interface UserSettingsViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userPointsTextField;

@end

@implementation UserSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userPointsTextField.delegate = self;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [tap setCancelsTouchesInView:NO];
    [self.view addGestureRecognizer:tap];
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
    
}

-(void)dismissKeyboard {
    [self.userPointsTextField resignFirstResponder];
}

@end
