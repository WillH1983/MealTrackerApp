//
//  MealTrackerTableViewController.m
//  MealTracker
//
//  Created by Will Hindenburg on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <BaseClassesSDK/User.h>

#import "MealTrackerTableViewController.h"
#import "MealEntryViewController.h"
#import "SaveMealService.h"
#import "RetrieveMealService.h"
#import "MealEaten.h"
#import "MealEatenService.h"
#import "Meal.h"
#import "DeleteMealService.h"

@interface MealTrackerTableViewController () <MealTextEntryDelegate>
@property (nonatomic, strong) NSArray *dataSource;
@property (strong, nonatomic) User *user;
@end


@implementation MealTrackerTableViewController

- (void)viewController:(id)sender didFinishWithMeal:(Meal *)meal {
    [[SaveMealService new] saveMeal:meal withSuccessBlock:^(Meal *meal) {
        [self.tableView reloadData];
    } andError:^(NSError *error) {
        [super showError:error withRetryBlock:^{
            [self viewController:sender didFinishWithMeal:meal];
        }];
    }];
}

- (void)viewController:(id)sender didFinishEditingMeal:(Meal *)meal {
    SaveMealService *saveService = [SaveMealService new];
    [saveService updateMeal:meal withSuccessBlock:^{
        
    } andError:^(NSError *error) {
        [super showError:error withRetryBlock:^{
            [self viewController:sender didFinishEditingMeal:meal];
        }];
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UINavigationController *navController = (UINavigationController *)segue.destinationViewController;
    [(MealEntryViewController *)navController.topViewController setTextEntryDelegate:self];
    
    if ([sender isKindOfClass:[UITableViewCell class]])
    {
        UITableViewCell *cell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];

        [(MealEntryViewController *)navController.topViewController setMealData:[self.dataSource objectAtIndex:indexPath.row]];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self retrieveMealsFromService];
    
}

- (void)retrieveMealsFromService {
    RetrieveMealService *mealService = [RetrieveMealService new];
    [super showActivityIndicatorAnimated:YES];
    [mealService retrieveMealsWithSuccessBlock:^(NSArray *meals) {
        self.dataSource = meals;
        [self.tableView reloadData];
        [super hideActivityIndicatorAnimated:YES];
    } andError:^(NSError *error) {
        [super hideActivityIndicatorAnimated:YES];
        [super showError:error withRetryBlock:^{
            [self retrieveMealsFromService];
        }];
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.user = [User persistentUserObject];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Meal Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
    [button setBackgroundImage:[UIImage imageNamed:@"plusButton"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(disclosureButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    cell.accessoryView = button;
    // ask NSFetchedResultsController for the NSMO at the row in question
    Meal *meal = [self.dataSource objectAtIndex:indexPath.row];
    // Then configure the cell using it ...
    cell.textLabel.text = meal.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ Weight Watchers Points", [meal.weightWatchersPlusPoints stringValue]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Meal *meal = [self.dataSource objectAtIndex:indexPath.row];
        [super showActivityIndicatorAnimated:YES];
        [[DeleteMealService new] removeMeal:meal withSuccessBlock:^{
            NSMutableArray *mutableCapsuleArray = [self.dataSource mutableCopy];
            [mutableCapsuleArray removeObjectAtIndex:indexPath.row];
            self.dataSource = [mutableCapsuleArray copy];
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [super hideActivityIndicatorAnimated:YES];
        } andError:^(NSError *error) {
            [super hideActivityIndicatorAnimated:YES];
            [super showError:error withRetryBlock:^{
                [self tableView:tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
            }];
        }];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

#pragma mark - Table view delegate

- (void)disclosureButtonPressed:(id)sender
{
    UITableViewCell *cell = (UITableViewCell *)[sender superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"plusButton"]];
    
    CGPoint p = [self.tableView convertPoint:cell.accessoryView.frame.origin fromView:cell];
    imageView.frame = CGRectMake(p.x, p.y, 35, 35);
    [self.view addSubview:imageView];
    
    
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        imageView.frame = CGRectMake(self.view.frame.size.width - ((self.view.frame.size.width - cell.accessoryView.frame.origin.x) + 50.0), (self.tableView.bounds.size.height + self.tableView.contentOffset.y), imageView.frame.size.width, imageView.frame.size.height);
        imageView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.99, 0.99);
    } completion:^(BOOL finished) {
        imageView.transform = CGAffineTransformIdentity;
        [imageView removeFromSuperview];
    }];

    
    MealEaten *mealEaten = [MealEaten new];
    mealEaten.meal = [self.dataSource objectAtIndex:indexPath.row];
    mealEaten.user = self.user;
    mealEaten.dateEaten = [NSDate date];
    [self saveMealEaten:mealEaten];
    
}

- (void)saveMealEaten:(MealEaten *)mealEaten {
    [super showActivityIndicatorAnimated:YES];
    [[MealEatenService new] saveMealEaten:mealEaten withSuccessBlock:^(MealEaten *mealEaten) {
        [super hideActivityIndicatorAnimated:YES];
    } andError:^(NSError *error) {
        [super hideActivityIndicatorAnimated:YES];
        [super showError:error withRetryBlock:^{
            [self saveMealEaten:mealEaten];
        }];
    }];
}

@end
