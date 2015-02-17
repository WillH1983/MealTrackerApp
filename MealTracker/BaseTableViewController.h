//
//  BaseTableViewController.h
//  MealTracker
//
//  Created by William Hindenburg on 2/16/15.
//
//

#import <UIKit/UIKit.h>

@interface BaseTableViewController : UITableViewController

/**
 * @brief Call this method to log the user out of the app.
 */
- (void)logout;

/**
 * @brief Call this method when an error has occured during a service call
 * @param error The error that was returned from a service call
 * @param retryBlock The block that will be executed if the user taps "Retry"
 */
- (void)showError:(NSError *)error withRetryBlock:(void (^)(void))retryBlock;

/**
 * @brief Override this method to support reloading data
 */
- (void)refreshData:(id)sender;

/**
 * @discussion Call this method to show the activity indicator
 * @param animated Send YES if the activity indicator should animated on the screen
 */
- (void)showActivityIndicatorAnimated:(BOOL)animated;

/**
 * @discussion Call this method to hide the activity indicator
 * @param animated Send YES if the activity indicator should animated off the screen
 */
- (void)hideActivityIndicatorAnimated:(BOOL)animated;

@end
