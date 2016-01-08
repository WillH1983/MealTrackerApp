//
//  ServiceErrors.h
//  BaseClasses
//
//  Created by William Hindenburg on 1/6/15.
//  Copyright (c) 2015 William Hindenburg. All rights reserved.
//

#ifndef BaseClasses_ServiceErrors_h
#define BaseClasses_ServiceErrors_h

typedef NS_ENUM(NSInteger, ServiceErrorCode) {
    ServiceErrorMaintenanceMode,
    ServiceErrorForceUpgrade
};

#define kMaintenanceModeErrorTitleKey @"maintModeErrorTitle"
#define kForceUpgradeTitleKey @"forceUpgradeTitle"
#define kForceUpgradeURL @"forceUpgradeURL"


#endif
