//
//  LifeServiceErrors.h
//  Life
//
//  Created by William Hindenburg on 1/6/15.
//  Copyright (c) 2015 William Hindenburg. All rights reserved.
//

#ifndef Life_LifeServiceErrors_h
#define Life_LifeServiceErrors_h

typedef NS_ENUM(NSInteger, LifeServiceErrorCode) {
    LifeServiceErrorMaintenanceMode,
    LifeServiceErrorForceUpgrade
};

#define kMaintenanceModeErrorTitleKey @"maintModeErrorTitle"
#define kForceUpgradeTitleKey @"forceUpgradeTitle"
#define kForceUpgradeURL @"forceUpgradeURL"


#endif
