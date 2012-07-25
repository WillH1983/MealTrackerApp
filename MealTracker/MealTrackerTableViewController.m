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

@interface MealTrackerTableViewController () <MealTextEntryDelegate>
@end


@implementation MealTrackerTableViewController
@synthesize mealDatabase = _mealDatabase;

- (void)setMealDatabase:(UIManagedDocument *)mealDatabase
{
    if (_mealDatabase != mealDatabase) {
        _mealDatabase = mealDatabase;
        [self useDocument];
    }
}

- (void)viewController:(id)sender didFinishWithMealMutableDictionary:(NSMutableDictionary *)dictionary
{
    [self.mealDatabase.managedObjectContext performBlock:^{
        [Meal mealForDictionaryInfo:dictionary inManagedObjectContext:self.mealDatabase.managedObjectContext];
        [self.mealDatabase saveToURL:self.mealDatabase.fileURL 
                    forSaveOperation:UIDocumentSaveForOverwriting 
                   completionHandler:^(BOOL success) {
                       if (!success) NSLog(@"failed to save document %@", self.mealDatabase.localizedName);
               }];
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [segue.destinationViewController setTextEntryDelegate:self];
    
    if ([sender isKindOfClass:[UITableViewCell class]])
    {
        UITableViewCell *cell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        Meal *meal = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        NSMutableDictionary *mealDetails = [Meal mutableMealDictionaryForMeal:meal inManagedObjectContext:self.mealDatabase.managedObjectContext];
        [segue.destinationViewController setMealDetails:mealDetails];
    }
}

- (void)useDocument
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:[self.mealDatabase.fileURL path]]) {
        // does not exist on disk, so create it
        [self.mealDatabase saveToURL:self.mealDatabase.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            [self setupFetchedResultsController];
        }];
    } else if (self.mealDatabase.documentState == UIDocumentStateClosed) {
        // exists on disk, but we need to open it
        [self.mealDatabase openWithCompletionHandler:^(BOOL success) {
            [self setupFetchedResultsController];
        }];
    } else if (self.mealDatabase.documentState == UIDocumentStateNormal) {
        // already open and ready to use
        [self setupFetchedResultsController];
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

- (void)fetchFlickrDataIntoDocument:(UIManagedDocument *)document
{
    
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!self.mealDatabase) {
        NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        url = [url URLByAppendingPathComponent:@"Default Photo Database"];

        self.mealDatabase = [[UIManagedDocument alloc] initWithFileURL:url]; // setter will create this for us on disk
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Meal Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // ask NSFetchedResultsController for the NSMO at the row in question
    Meal *meal = [self.fetchedResultsController objectAtIndexPath:indexPath];
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
        Meal *meal = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [self.mealDatabase.managedObjectContext deleteObject:meal];
        [self.mealDatabase saveToURL:self.mealDatabase.fileURL 
                    forSaveOperation:UIDocumentSaveForOverwriting 
                   completionHandler:^(BOOL success) {
                       if (!success) NSLog(@"failed to save document %@", self.mealDatabase.localizedName);
                   }];
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self.mealDatabase.managedObjectContext performBlock:^{
        DateEaten *dateEaten = [DateEaten dailyMealsinManagedObjectContext:self.mealDatabase.managedObjectContext];
        
        Meal *meal = [self.fetchedResultsController objectAtIndexPath:indexPath];
        NSLog(@"%@", dateEaten);
        [meal addWhenEatenObject:dateEaten];
        [self.mealDatabase saveToURL:self.mealDatabase.fileURL 
                    forSaveOperation:UIDocumentSaveForOverwriting 
                   completionHandler:^(BOOL success) {
                       if (!success) NSLog(@"failed to save document %@", self.mealDatabase.localizedName);
                   }];
        NSLog(@"%@", dateEaten);
        NSLog(@"%@", meal);
    }];
}

@end
