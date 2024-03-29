//
//  UserSettingsViewController.m
//  MealTracker
//
//  Created by William Hindenburg on 2/17/15.
//
//

#import "UserSettingsViewController.h"
#import "MealTracker-Swift.h"

@import BaseClassesSwift;

@interface UserSettingsViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userPointsTextField;
@property (strong, nonatomic) User *user;
@end

@implementation UserSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.user = [User persistentUserObject];
    self.userPointsTextField.text = [NSString stringWithFormat:@"%ld", (long)[self.user.pointsPerWeek integerValue]];
    self.userPointsTextField.delegate = self;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [tap setCancelsTouchesInView:NO];
    [self.view addGestureRecognizer:tap];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [super showActivityIndicatorAnimated:YES];
    [[UserService new] getPoints:^(Points * _Nonnull points) {
        [super hideActivityIndicatorAnimated:YES];
        self.userPointsTextField.text = points.points;
        self.user.pointsPerWeek = [NSNumber numberWithInteger:[points.points integerValue]];
        [self.user save];
    } errorBlock:^(NSError * _Nonnull error) {
        [super hideActivityIndicatorAnimated:YES];
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [super showActivityIndicatorAnimated:YES];
    [self saveWeeklyPoints:textField.text];
}

- (void)saveWeeklyPoints:(NSString *)points {
    self.user.pointsPerWeek = [NSNumber numberWithInteger:[points integerValue]];
    Points *pointsModel = [Points new];
    pointsModel.points = points;
    
    UserService *service = [UserService new];
    [service updatePoints:pointsModel successBlock:^(Points * _Nonnull updatedPoints) {
        [super hideActivityIndicatorAnimated:YES];
    } errorBlock:^(NSError * _Nonnull error) {
        [super hideActivityIndicatorAnimated:YES];
        [super showError:error withRetryBlock:^{
            [self saveWeeklyPoints:points];
        }];
    }];
}

- (IBAction)saveButtonTapped:(id)sender {
    if (self.userPointsTextField.text.length > 0) {
        [self saveWeeklyPoints:self.userPointsTextField.text];
        [self dismissKeyboard];
    }
}

- (IBAction)logoutTapped:(id)sender {
    [super logout];
}

-(void)dismissKeyboard {
    [self.userPointsTextField resignFirstResponder];
}

@end
