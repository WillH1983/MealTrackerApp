//
//  BaseTableViewController.h
//  MealTracker
//
//  Created by William Hindenburg on 2/16/15.
//
//

#import <UIKit/UIKit.h>
#import <BaseClasses/BaseClasses.h>

@interface MealBaseTableViewController : BaseTableViewController

/**
 * @brief Call this method to log the user out of the app.
 */
- (void)logout;

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
