//
//  BaseLifeService.m
//  Life
//
//  Created by William Hindenburg on 1/3/15.
//  Copyright (c) 2015 William Hindenburg. All rights reserved.
//


#import "BaseService.h"

@implementation BaseService

- (instancetype)init {
    self = [super init];
    if (self) {
//        RKLogConfigureByName("RestKit/Network", RKLogLevelTrace);
    }
    return self;
}

- (NSString *)baseURL {
    return @"https://api.parse.com";
}

- (NSDictionary *)parameters {
    return nil;
}

- (NSString *)rootRequestKeyPath {
    return nil;
}

@end
