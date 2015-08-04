//
//  TrackerTableViewController.m
//  MealTracker
//
//  Created by Will Hindenburg on 7/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TrackerTableViewController.h"
#import "RetrieveMealHistoryService.h"
#import "MealEaten.h"
#import "Meal.h"
#import "DeleteMealEatenService.h"

@import BaseClasses;

@interface TrackerTableViewController ()
@property (strong, nonatomic) User *user;
@property (strong, nonatomic) NSArray *dataSource;
@end

@implementation TrackerTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self retrieveMealHistory];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.user = [User persistentUserObject];
}

- (void)retrieveMealHistory {
    [super showActivityIndicatorAnimated:YES];
    RetrieveMealHistoryService *service = [RetrieveMealHistoryService new];
    [service loadMealHistoryBasedOnUser:self.user withSuccessBlock:^(NSArray *data) {
        self.dataSource = data;
        [self.tableView reloadData];
        [super hideActivityIndicatorAnimated:YES];
    } andError:^(NSError *error) {
        [super hideActivityIndicatorAnimated:YES];
        [super showError:error withRetryBlock:^{
            [self retrieveMealHistory];
        }];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Date Eaten Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    MealEaten *mealEaten = [self mealEatenForIndexPath:indexPath];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    NSString *formattedDateString = [dateFormatter stringFromDate:mealEaten.dateEaten];
    NSString *fullString = [[NSString alloc] initWithFormat:@"%@ - %@ Points", formattedDateString, [mealEaten.meal.weightWatchersPlusPoints stringValue]];
    cell.detailTextLabel.text = fullString;
    cell.textLabel.text = mealEaten.meal.name;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 45.0f;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *dataSourceForSection = [self.dataSource objectAtIndex:section];
    NSArray *array = [dataSourceForSection valueForKey:@"meals"];
    return array.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSDictionary *dataSourceForSection = [self.dataSource objectAtIndex:section];
    NSDate *date = [dataSourceForSection valueForKey:@"month"];
    NSArray *array = [dataSourceForSection valueForKey:@"meals"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    dateFormatter.timeStyle = NSDateFormatterNoStyle;
    
    NSInteger points = 0;
    for (MealEaten *dateEaten in array)
    {
        points += [dateEaten.meal.weightWatchersPlusPoints integerValue];
    }
    NSInteger pointsLeft = [self.user.pointsPerWeek integerValue] - points;
    NSString *sectionTitle = [dateFormatter stringFromDate:date];
    NSString *fullSectionTitle = [[NSString alloc] initWithFormat:@"%@ - %li Points Left", sectionTitle, (long)pointsLeft];
    return fullSectionTitle;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [super showActivityIndicatorAnimated:YES];
        MealEaten *meal = [self mealEatenForIndexPath:indexPath];
        [[DeleteMealEatenService new] removeMealEaten:meal withSuccessBlock:^{
            NSMutableArray *mutableCapsuleArray = [self dataSourceArrayForSection:indexPath.section];
            [mutableCapsuleArray removeObjectAtIndex:indexPath.row];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
            [super hideActivityIndicatorAnimated:YES];
        } andError:^(NSError *error) {
            [super hideActivityIndicatorAnimated:YES];
            [super showError:error withRetryBlock:^{
                [self tableView:tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
            }];
        }];
    }
}

- (NSMutableArray *)dataSourceArrayForSection:(NSInteger)section {
    NSDictionary *dataSourceForSection = [self.dataSource objectAtIndex:section];
    NSMutableArray *array = [dataSourceForSection valueForKey:@"meals"];
    return array;
}

- (MealEaten *)mealEatenForIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dataSourceForSection = [self.dataSource objectAtIndex:indexPath.section];
    NSArray *array = [dataSourceForSection valueForKey:@"meals"];
    MealEaten *mealEaten = [array objectAtIndex:indexPath.row];
    return mealEaten;
}

@end
