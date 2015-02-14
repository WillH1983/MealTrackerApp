//
//  MealTrackerTableViewController.m
//  MealTracker
//
//  Created by Will Hindenburg on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MealTrackerTableViewController.h"
#import "MealEntryViewController.h"
#import "Meal+Create.h"
#import "DateEaten+Create.h"
#import <CoreData/CoreData.h>
#import "MealTrackerAppDelegate.h"
#import "SaveMealService.h"
#import "RetrieveMealService.h"
#import "User.h"
#import "MealEaten.h"
#import "MealEatenService.h"

@interface MealTrackerTableViewController () <MealTextEntryDelegate>
@property (nonatomic, strong) NSArray *dataSource;
@property (strong, nonatomic) User *user;
@end


@implementation MealTrackerTableViewController
@synthesize mealDatabase = _mealDatabase;

- (void)viewController:(id)sender didFinishWithMealMutableDictionary:(NSMutableDictionary *)dictionary
{
    [[SaveMealService new] saveMeal:[Meal mealForDictionaryInfo:dictionary] withSuccessBlock:^{
        
    } andError:^(NSError *error) {
        
    }];
}

- (void)viewController:(id)sender didFinishEditingMealMutableDictionary:(NSMutableDictionary *)newMealDetails withOldMealMutableDictionary:(NSMutableDictionary *)oldMealDetails
{
    [self.mealDatabase.managedObjectContext performBlock:^{
        [MealCoreData updatedMealOldDictionaryInfo:oldMealDetails withNewDictionaryInfo:newMealDetails inManagedObjectContext:self.mealDatabase.managedObjectContext];
        [self.mealDatabase saveToURL:self.mealDatabase.fileURL 
                    forSaveOperation:UIDocumentSaveForOverwriting 
                   completionHandler:^(BOOL success) {
                       if (!success) NSLog(@"failed to save document %@", self.mealDatabase.localizedName);
                   }];
    }];
}

- (void)viewController:(id)sender didFinishEditingMeal:(Meal *)meal {
    SaveMealService *saveService = [SaveMealService new];
    [saveService updateMeal:meal withSuccessBlock:^{
        NSLog(@"Success");
    } andError:^(NSError *error) {
        NSLog(@"%@", error);
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
        MealCoreData *meal = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        NSMutableDictionary *mealDetails = [MealCoreData mutableMealDictionaryForMeal:meal inManagedObjectContext:self.mealDatabase.managedObjectContext];
        [(MealEntryViewController *)navController.topViewController setMealDetails:mealDetails];
        [(MealEntryViewController *)navController.topViewController setMealData:[self.dataSource objectAtIndex:indexPath.row]];
    }
}

- (void)setupFetchedResultsController // attaches an NSFetchRequest to this UITableViewController
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Meal"];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)]];
    // no predicate because we want ALL the Photographers
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:self.mealDatabase.managedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(documentStateChanged:)
                                                 name:UIDocumentStateChangedNotification object:self.mealDatabase];
    
    MealTrackerAppDelegate *appDelegate = (MealTrackerAppDelegate *)[[UIApplication sharedApplication] delegate];
    self.mealDatabase = appDelegate.mealDatabase;
    
    if (self.mealDatabase.documentState == UIDocumentStateNormal)
    {
        [self setupFetchedResultsController];
    }
    
    RetrieveMealService *mealService = [RetrieveMealService new];
    [mealService retrieveMealsWithSuccessBlock:^(NSArray *meals) {
        self.dataSource = meals;
        [self.tableView reloadData];
    } andError:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    NSDictionary *userDictionary = [[NSUserDefaults standardUserDefaults] objectForKey:@"userData"];
    self.user = [User userObjectFromDictionary:userDictionary];
}

- (void)viewDidDisappear:(BOOL)animated
{
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIDocumentStateChangedNotification 
                                                  object:self.mealDatabase];
}

- (void)documentStateChanged:(NSNotification *)notification
{
    id notificationObject = [notification object];
    if ([notificationObject isKindOfClass:[UIManagedDocument class]])
    {
        UIManagedDocument *document = notificationObject;
        if (document.documentState == UIDocumentStateNormal) [self setupFetchedResultsController];
    }
    
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
    MealCoreData *meal = [self.dataSource objectAtIndex:indexPath.row];
    // Then configure the cell using it ...
    cell.textLabel.text = meal.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ Weight Watchers Points", [meal.weightWatchersPlusPoints stringValue]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //If the table view is asking to cmmit a delete command
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        MealCoreData *meal = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [self.mealDatabase.managedObjectContext deleteObject:meal];
        [self.mealDatabase saveToURL:self.mealDatabase.fileURL 
                    forSaveOperation:UIDocumentSaveForOverwriting 
                   completionHandler:^(BOOL success) {
                       if (!success) NSLog(@"failed to save document %@", self.mealDatabase.localizedName);
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
    
    [[MealEatenService new] saveMealEaten:mealEaten withSuccessBlock:^(MealEaten *mealEaten) {
        
    } andError:^(NSError *error) {
        
    }];
}

@end
