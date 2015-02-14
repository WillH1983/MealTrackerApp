//
//  TrackerTableViewController.m
//  MealTracker
//
//  Created by Will Hindenburg on 7/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TrackerTableViewController.h"
#import "Meal+Create.h"
#import "DateEaten+Create.h"
#import "MealTrackerAppDelegate.h"
#import "RetrieveMealHistoryService.h"
#import "User.h"
#import "MealEaten.h"

@interface TrackerTableViewController ()
@property (strong, nonatomic) User *user;
@property (strong, nonatomic) NSArray *dataSource;
@end

@implementation TrackerTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    NSDictionary *userDictionary = [[NSUserDefaults standardUserDefaults] objectForKey:@"userData"];
    self.user = [User userObjectFromDictionary:userDictionary];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    RetrieveMealHistoryService *service = [RetrieveMealHistoryService new];
    [service loadMealHistoryBasedOnUser:self.user withSuccessBlock:^(NSArray *data) {
        self.dataSource = data;
        [self.tableView reloadData];
    } andError:^(NSError *error) {
        
    }];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Date Eaten Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // ask NSFetchedResultsController for the NSMO at the row in question
    MealEaten *mealEaten = [self.dataSource objectAtIndex:indexPath.row];
    // Then configure the cell using it ...
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    NSString *formattedDateString = [dateFormatter stringFromDate:mealEaten.dateEaten];
    NSString *fullString = [[NSString alloc] initWithFormat:@"%@ - %@ Points", formattedDateString, [mealEaten.meal.weightWatchersPlusPoints stringValue]];
    cell.detailTextLabel.text = fullString;
    cell.textLabel.text = mealEaten.meal.name;
    
    return cell;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//
//    NSString *sectionTitle = [[[self.fetchedResultsController sections] objectAtIndex:section] name];
//    NSString *fullSectionTitle = [[NSString alloc] initWithFormat:@"%@ - %i Points Used", sectionTitle, points]; 
//    return fullSectionTitle;
//}

//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

@end
