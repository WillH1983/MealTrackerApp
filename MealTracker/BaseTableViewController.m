//
//  BaseTableViewController.m
//  MealTracker
//
//  Created by William Hindenburg on 2/16/15.
//
//

#import "BaseTableViewController.h"
#import "KVNProgress.h"
@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (void)logout {

}

- (void)refreshData:(id)sender {
    
}

- (void)showError:(NSError *)error withRetryBlock:(void (^)(void))completion {
    NSString *errorMessage = [error localizedDescription];
    NSString *title;
    UIAlertControllerStyle style = UIAlertControllerStyleActionSheet;
    
    UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:title message:errorMessage preferredStyle:style];
    
    [errorAlert addAction:[UIAlertAction actionWithTitle:@"Retry" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        if (completion) completion();
    }]];
    
    [errorAlert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:errorAlert animated:YES completion:nil];
    
}

- (void)showActivityIndicatorAnimated:(BOOL)animated {
    [KVNProgress show];
}

- (void)hideActivityIndicatorAnimated:(BOOL)animated {
    [KVNProgress dismiss];
}

@end
