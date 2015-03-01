//
//  ApplicationConfigManager.h
//  Life
//
//  Created by William Hindenburg on 1/3/15.
//  Copyright (c) 2015 William Hindenburg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApplicationConfigManager : NSObject

+ (instancetype)sharedManager;

- (void)fetchConfig;
- (BOOL)isInMaintenanceMode;
- (NSString *)maintenanceModeMessage;
- (BOOL)shouldForceUpgrade;
- (NSString *)forceUpgradeMessage;
- (NSString *)forceUpgradeTitle;
- (NSString *)forceUpgradeURL;

@end
