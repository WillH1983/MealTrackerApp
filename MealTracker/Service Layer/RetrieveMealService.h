//
//  RetrieveMealService.h
//  MealTracker
//
//  Created by William Hindenburg on 2/12/15.
//
//

#import <BaseClassesSDK/BaseService.h>

@interface RetrieveMealService : BaseService <Service>
- (void)retrieveMealsWithSuccessBlock:(void (^)(NSArray *meals))successBlock andError:(void (^)(NSError *error))errorBlock;
@end
