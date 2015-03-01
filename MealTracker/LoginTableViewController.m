//
//  LoginTableViewController.m
//  MealTracker
//
//  Created by William Hindenburg on 2/11/15.
//
//

#import <BaseClassesSDK/User.h>

#import "LoginTableViewController.h"
#import <BaseClassesSDK/AuthenticationService.h>

@interface LoginTableViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation LoginTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    User *user = [User persistentUserObject];
    if (user.sessionToken2) {
        [self performSegueWithIdentifier:@"tabbar" sender:self];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)registerNowTapped:(id)sender {
    AuthenticationService *authService = [AuthenticationService new];
    User *user = [User new];
    user.username2 = self.userName.text;
    user.password2 = self.password.text;
    [super showActivityIndicatorAnimated:YES];
    [authService registerUser:user withSuccessBlock:^(User *user) {
        user.password2 = nil;
        [self saveUser:user];
        [self performSegueWithIdentifier:@"tabbar" sender:self];
        self.userName.text = @"";
        self.password.text = @"";
        [super hideActivityIndicatorAnimated:YES];
    } andError:^(NSError *error) {
        [super hideActivityIndicatorAnimated:YES];
        [super showError:error withRetryBlock:^{
            [self registerNowTapped:sender];
        }];
    }];
}

- (IBAction)loginTapped:(id)sender {
    AuthenticationService *authService = [AuthenticationService new];
    User *user = [User new];
    user.username2 = self.userName.text;
    user.password2 = self.password.text;
    [super showActivityIndicatorAnimated:YES];
    [authService loginUser:user withSuccessBlock:^(User *user) {
        [self saveUser:user];
        [self performSegueWithIdentifier:@"tabbar" sender:self];
        [super hideActivityIndicatorAnimated:YES];
        self.userName.text = @"";
        self.password.text = @"";
    } andError:^(NSError *error) {
        [super hideActivityIndicatorAnimated:YES];
        [super showError:error withRetryBlock:^{
            [self loginTapped:sender];
        }];
    }];
}

- (void)saveUser:(User *)user {
    [user save];
}

#pragma mark - Table view data source


@end
