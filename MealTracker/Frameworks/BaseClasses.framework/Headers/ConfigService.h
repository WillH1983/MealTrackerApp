//
//  ConfigService.h
//  Life
//
//  Created by William Hindenburg on 1/8/15.
//  Copyright (c) 2015 William Hindenburg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Service.h"
#import "Config.h"
#import "BaseService.h"

@interface ConfigService : BaseService <Service>
- (void)loadConfigDataWithSuccessBlock:(void (^)(Config *data))successBlock andError:(void (^)(NSError *error))errorBlock;
@end
