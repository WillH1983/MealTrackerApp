//
//  BaseTableViewController.m
//  MealTracker
//
//  Created by William Hindenburg on 2/16/15.
//
//

#import "MealBaseTableViewController.h"
#import "KVNProgress.h"
#import "ServiceErrors.h"

@import BaseClassesSwift;

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

- (void)showError:(NSError *)error withRetryBlock:(void (^)(void))completion {
    if ([User persistentUserObject].sessionToken) {
        NSString *errorMessage = [error localizedDescription];
        NSString *title;
        UIAlertControllerStyle style = UIAlertControllerStyleActionSheet;
        
        if (error.code == ServiceErrorForceUpgrade) {
            title = [error.userInfo objectForKey:kForceUpgradeTitleKey];
            style = UIAlertControllerStyleAlert;
        } else if ([error code] == ServiceErrorMaintenanceMode) {
            title = [error.userInfo objectForKey:kMaintenanceModeErrorTitleKey];
        }
        
        if (title == nil) {
            title = @"Error";
        }
        
        UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:title message:errorMessage preferredStyle:style];
        
        if (error.code != ServiceErrorForceUpgrade) {
            [errorAlert addAction:[UIAlertAction actionWithTitle:@"Retry" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                if (completion) completion();
            }]];
        } else {
            NSString *url = [error.userInfo objectForKey:kForceUpgradeURL];
            if (url) {
                [errorAlert addAction:[UIAlertAction actionWithTitle:@"Upgrade" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
                    
                }]];
            }
            
        }
        
        [errorAlert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:errorAlert animated:YES completion:nil];
    }
    
}

@end
