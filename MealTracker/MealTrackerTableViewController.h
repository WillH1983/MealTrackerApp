//
//  MealTrackerTableViewController.h
//  MealTracker
//
//  Created by Will Hindenburg on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"

@interface MealTrackerTableViewController : CoreDataTableViewController

@property (nonatomic, strong) UIManagedDocument *mealDatabase;  // Model is a Core Data database of photos

@end
