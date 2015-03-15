//
//  LifeService.h
//  Life
//
//  Created by William Hindenburg on 1/4/15.
//  Copyright (c) 2015 William Hindenburg. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RKObjectMapping;

@protocol MealService <NSObject>
@optional
- (NSString *)serviceURL;
- (RKObjectMapping *)mappingProvider;
- (RKObjectMapping *)serializedMappingProvider;
- (NSString *)baseURL;
- (NSString *)rootKeyPath;
- (NSString *)rootRequestKeyPath;
- (NSDictionary *)parameters;
@end
