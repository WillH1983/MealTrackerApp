//
//  Config.swift
//  BaseClasses
//
//  Created by William Hindenburg on 8/2/15.
//  Copyright © 2015 William Hindenburg. All rights reserved.
//

import UIKit

public class Config: NSObject {
    public var MaintenanceMode:Dictionary<String, AnyObject>? = nil
    public var configRefreshIntervalSeconds:NSNumber? = nil
    public var forceUpgrade:Dictionary<String, AnyObject>? = nil
    
}
