//
//  RetrieveMealHistoryService.m
//  MealTracker
//
//  Created by William Hindenburg on 2/14/15.
//
//

#import <BaseClasses/ServiceClient.h>
#import <BaseClasses/User.h>
#import <BaseClasses/RestKitMapping.h>

#import "RetrieveMealHistoryService.h"
#import "MealEaten.h"
#import "Meal.h"

@interface RetrieveMealHistoryService()
@property (strong, nonatomic) User *user;
@end

@implementation RetrieveMealHistoryService

- (void)loadMealHistoryBasedOnUser:(User *)user withSuccessBlock:(void (^)(NSArray * data))successBlock andError:(void (^)(NSError *error))errorBlock {
    self.user = user;
    ServiceClient *serviceClient = [ServiceClient new];
    [serviceClient getForService:self withSuccess:^(RKMappingResult *result) {
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"dateEaten" ascending:NO selector:@selector(compare:)    ];
        NSArray *sortedArrayOfMealsEaten = [result.array sortedArrayUsingDescriptors:@[sortDescriptor]];
        
        NSMutableArray *mutableArrayOfMonthDictionaries = [NSMutableArray new];
        NSCalendar *currentCalender = [NSCalendar currentCalendar];
        NSDate *lastDate = [NSDate distantPast];
        NSMutableDictionary *currentMonthDictionary;
        for (MealEaten *mealEaten in sortedArrayOfMealsEaten) {
            BOOL isInTheSameDay = [currentCalender isDate:mealEaten.dateEaten equalToDate:lastDate toUnitGranularity:NSCalendarUnitDay];
            if (isInTheSameDay) {
                NSMutableArray *mutableArray = [currentMonthDictionary objectForKey:@"meals"];
                [mutableArray addObject:mealEaten];
            } else {
                if (currentMonthDictionary) {
                    [mutableArrayOfMonthDictionaries addObject:currentMonthDictionary];
                }
                
                currentMonthDictionary = [NSMutableDictionary new];
                [currentMonthDictionary setObject:mealEaten.dateEaten forKey:@"month"];
                NSMutableArray *currentMonthArray = [NSMutableArray new];
                [currentMonthArray addObject:mealEaten];
                [currentMonthDictionary setObject:currentMonthArray forKey:@"meals"];
            }
            lastDate = mealEaten.dateEaten;
        }
        if (currentMonthDictionary) {
            [mutableArrayOfMonthDictionaries addObject:currentMonthDictionary];
        }
        
        successBlock([mutableArrayOfMonthDictionaries copy]);
    } andError:^(NSError *error) {
        errorBlock(error);
    }];
}

- (NSString *)serviceURL {
    NSString *serviceString = [NSString stringWithFormat:@"/1/classes/%@", NSStringFromClass([MealEaten class])];
    return [serviceString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

- (NSDictionary *)parameters {
    NSString *query = [NSString stringWithFormat:@"{\"user\":{\"__type\": \"Pointer\", \"className\": \"_User\",\"objectId\": \"%@\"}}", self.user.objectId];
    NSString *query2 = [NSString stringWithFormat:@"meal"];
    return @{@"where":query, @"include":query2};
}

- (NSString *)rootKeyPath {
    return @"results";
}

- (RKObjectMapping *)mappingProvider {
    RKObjectMapping *mealEatenObjectMapping = [RKObjectMapping mappingForClass:[MealEaten class]];
    [mealEatenObjectMapping addAttributeMappingsFromDictionary:@{@"objectId":@"objectId"}];
    [mealEatenObjectMapping addAttributeMappingsFromDictionary:@{@"dateEaten":@"dateEaten"}];
    
    
    RKObjectMapping *mealMapping = [[RKObjectMapping alloc] initWithClass:[Meal class]];
    [mealMapping addAttributeMappingsFromDictionary:@{@"calories":@"calories"}];
    [mealMapping addAttributeMappingsFromDictionary:@{@"carbs":@"carbs"}];
    [mealMapping addAttributeMappingsFromDictionary:@{@"dietaryFiber":@"dietaryFiber"}];
    [mealMapping addAttributeMappingsFromDictionary:@{@"mealDescription":@"mealDescription"}];
    [mealMapping addAttributeMappingsFromDictionary:@{@"name":@"name"}];
    [mealMapping addAttributeMappingsFromDictionary:@{@"protein":@"protein"}];
    [mealMapping addAttributeMappingsFromDictionary:@{@"servingSize":@"servingSize"}];
    [mealMapping addAttributeMappingsFromDictionary:@{@"totalFat":@"totalFat"}];
    [mealMapping addAttributeMappingsFromDictionary:@{@"weightWatchersPlusPoints":@"weightWatchersPlusPoints"}];
    [mealMapping addAttributeMappingsFromDictionary:@{@"whenEaten":@"whenEaten"}];
    [mealMapping addAttributeMappingsFromDictionary:@{@"objectId":@"objectId"}];
    
    RKRelationshipMapping *relationshipMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"meal" toKeyPath:@"meal" withMapping:mealMapping];
    [mealEatenObjectMapping addPropertyMapping:relationshipMapping];
    
    return mealEatenObjectMapping;
}

@end
