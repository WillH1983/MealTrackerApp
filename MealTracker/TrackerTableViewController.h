//
//  TrackerTableViewController.h
//  MealTracker
//
//  Created by Will Hindenburg on 7/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CoreDataTableViewController.h"

@interface TrackerTableViewController : UITableViewController
@property (nonatomic, strong) UIManagedDocument *mealDatabase;
@end
