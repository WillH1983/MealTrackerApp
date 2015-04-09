//
//  BaseTableViewController.m
//  MealTracker
//
//  Created by William Hindenburg on 2/16/15.
//
//

#import <BaseClasses/User.h>

#import "MealBaseTableViewController.h"
#import "KVNProgress.h"

@interface MealBaseTableViewController ()

@end

@implementation MealBaseTableViewController

- (void)logout {
    [User deleteUser];
    [self.tabBarController.navigationController popToRootViewControllerAnimated:YES];
}

- (void)refreshData:(id)sender {
    
}

- (void)showActivityIndicatorAnimated:(BOOL)animated {
    [KVNProgress show];
}

- (void)hideActivityIndicatorAnimated:(BOOL)animated {
    [KVNProgress dismiss];
}

@end
