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

@interface TrackerTableViewController ()
@end

@implementation TrackerTableViewController
@synthesize mealDatabase = _mealDatabase;

- (void)setMealDatabase:(UIManagedDocument *)mealDatabase
{
    if (_mealDatabase != mealDatabase) {
        _mealDatabase = mealDatabase;
        [self useDocument];
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
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"DateEaten"];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO selector:@selector(localizedCaseInsensitiveCompare:)]];
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
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!self.mealDatabase) {
        NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        url = [url URLByAppendingPathComponent:@"Default Photo Database"];
        
        self.mealDatabase = [[UIManagedDocument alloc] initWithFileURL:url]; // setter will create this for us on disk
    }
    [self performFetch];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Date Eaten Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // ask NSFetchedResultsController for the NSMO at the row in question
    DateEaten *dateEaten = [self.fetchedResultsController objectAtIndexPath:indexPath];
    // Then configure the cell using it ...
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    NSString *formattedDateString = [dateFormatter stringFromDate:dateEaten.date];
    cell.detailTextLabel.text = formattedDateString;
    cell.textLabel.text = dateEaten.whatWasEaten.name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //If the table view is asking to cmmit a delete command
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        DateEaten *dateEaten = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [self.mealDatabase.managedObjectContext deleteObject:dateEaten];
        [self.mealDatabase saveToURL:self.mealDatabase.fileURL 
                    forSaveOperation:UIDocumentSaveForOverwriting 
                   completionHandler:^(BOOL success) {
                       if (!success) NSLog(@"failed to save document %@", self.mealDatabase.localizedName);
                   }];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
