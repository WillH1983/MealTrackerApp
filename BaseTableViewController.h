//
//  BaseTableViewController.h
//  BaseClasses
//
//  Created by William Hindenburg on 4/5/15.
//  Copyright (c) 2015 William Hindenburg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewController : UITableViewController

/**
 * @brief Call this method when an error has occured during a service call
 * @param error The error that was returned from a service call
 * @param retryBlock The block that will be executed if the user taps "Retry"
 */
- (void)showError:(NSError *)error withRetryBlock:(void (^)(void))retryBlock;

@end
