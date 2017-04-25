//
//  Config.swift
//  BaseClasses
//
//  Created by William Hindenburg on 8/2/15.
//  Copyright © 2015 William Hindenburg. All rights reserved.
//

import UIKit

open class Config: NSObject {
    open var MaintenanceMode:Dictionary<String, AnyObject>? = nil
    open var configRefreshIntervalSeconds:NSNumber? = nil
    open var forceUpgrade:Dictionary<String, AnyObject>? = nil
    
}
