//
//  DateEaten+Create.m
//  MealTracker
//
//  Created by William Hindenburg on 7/25/12.
//
//

#import "DateEaten+Create.h"

@implementation DateEaten (Create)

+ (DateEaten *)dailyMealsinManagedObjectContext:(NSManagedObjectContext *)context
{
    
    
    DateEaten *dateEaten = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"DateEaten"];
    request.predicate = [NSPredicate predicateWithFormat:@"date = %@", [NSDate date]];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error = nil;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if ([matches count])
    {
        dateEaten = [matches lastObject];
    }
    else
    {
        dateEaten = [NSEntityDescription insertNewObjectForEntityForName:@"DateEaten" inManagedObjectContext:context];
        dateEaten.date = [NSDate date];
    }
    
    return dateEaten;
    
}

@end
