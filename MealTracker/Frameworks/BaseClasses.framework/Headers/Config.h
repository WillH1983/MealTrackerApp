//
//  Config.h
//  Life
//
//  Created by William Hindenburg on 1/8/15.
//  Copyright (c) 2015 William Hindenburg. All rights reserved.
//

#import "BaseModel.h"

@interface Config : BaseModel
@property (strong, nonatomic) NSDictionary *MaintenanceMode;
@property (strong, nonatomic) NSNumber *configRefreshIntervalSeconds;
@property (strong, nonatomic) NSDictionary *forceUpgrade;
@end
