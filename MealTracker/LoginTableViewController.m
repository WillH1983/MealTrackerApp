//
//  LoginTableViewController.m
//  MealTracker
//
//  Created by William Hindenburg on 2/11/15.
//
//

#import "LoginTableViewController.h"
#import "MealAuthenticationService.h"
#import "User.h"

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
    NSDictionary *userDictionary = [[NSUserDefaults standardUserDefaults] objectForKey:@"userData"];
    User *user = [User userObjectFromDictionary:userDictionary];
    if (user.sessionToken) {
        [self performSegueWithIdentifier:@"tabbar" sender:self];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)registerNowTapped:(id)sender {
    MealAuthenticationService *authService = [MealAuthenticationService new];
    User *user = [User new];
    user.username = self.userName.text;
    user.password = self.password.text;
    [authService registerUser:user withSuccessBlock:^(User *user) {
        user.password = nil;
        [self saveUser:user];
        [self performSegueWithIdentifier:@"tabbar" sender:self];
    } andError:^(NSError *error) {
        
    }];
}

- (IBAction)loginTapped:(id)sender {
    MealAuthenticationService *authService = [MealAuthenticationService new];
    User *user = [User new];
    user.username = self.userName.text;
    user.password = self.password.text;
    [authService loginUser:user withSuccessBlock:^(User *user) {
        [self saveUser:user];
        [self performSegueWithIdentifier:@"tabbar" sender:self];
    } andError:^(NSError *error) {
        
    }];
}

- (void)saveUser:(User *)user {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[user dictionaryRepresentation] forKey:@"userData"];
    [userDefaults synchronize];
}

#pragma mark - Table view data source


@end