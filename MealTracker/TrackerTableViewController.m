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
@synthesize mealDatabase = _mealDatabase;

- (void)setupFetchedResultsController // attaches an NSFetchRequest to this UITableViewController
{
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"DateEaten"];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO selector:@selector(compare:)]];
    // no predicate because we want ALL the Photographers
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:self.mealDatabase.managedObjectContext
                                                                          sectionNameKeyPath:@"date.day"
                                                                                   cacheName:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

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
    MealTrackerAppDelegate *appDelegate = (MealTrackerAppDelegate *)[[UIApplication sharedApplication] delegate];
    self.mealDatabase = appDelegate.mealDatabase;
    
    if (self.mealDatabase.documentState == UIDocumentStateNormal)
    {
        [self setupFetchedResultsController];
    }
    
    RetrieveMealHistoryService *service = [RetrieveMealHistoryService new];
    [service loadMealHistoryBasedOnUser:self.user withSuccessBlock:^(NSArray *data) {
        self.dataSource = data;
        [self.tableView reloadData];
    } andError:^(NSError *error) {
        
    }];
    
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	NSArray *sections = [self.fetchedResultsController sections];
    id <NSFetchedResultsSectionInfo> info = [sections objectAtIndex:section];
    NSArray *array = info.objects;
    
    int points = 0;
    for (DateEaten *dateEaten in array)
    {
        points += [dateEaten.whatWasEaten.weightWatchersPlusPoints integerValue];
    }
    NSString *sectionTitle = [[[self.fetchedResultsController sections] objectAtIndex:section] name];
    NSString *fullSectionTitle = [[NSString alloc] initWithFormat:@"%@ - %i Points Used", sectionTitle, points]; 
    return fullSectionTitle;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //If the table view is asking to cmmit a delete command
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.mealDatabase.managedObjectContext performBlock:^{
            DateEaten *dateEaten = [self.fetchedResultsController objectAtIndexPath:indexPath];
            [self.mealDatabase.managedObjectContext deleteObject:dateEaten];
            [self.mealDatabase saveToURL:self.mealDatabase.fileURL 
                        forSaveOperation:UIDocumentSaveForOverwriting 
                       completionHandler:^(BOOL success) {
                           if (!success)
                           {
                               NSLog(@"failed to save document %@", self.mealDatabase.localizedName);
                           }
                           [self.tableView reloadData];
                       }];
        }];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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

@end
