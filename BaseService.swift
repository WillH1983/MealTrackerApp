//
//  BaseService.swift
//  BaseClasses
//
//  Created by William Hindenburg on 8/2/15.
//  Copyright © 2015 William Hindenburg. All rights reserved.
//

import UIKit

open class SwiftBaseService: NSObject {
    open func baseURL() -> String {
        return "https://api.parse.com"
    }
    
    open func parameters() -> [String: AnyObject]? {
        return nil
    }
    
    open func rootRequestKeyPath() -> String? {
        return nil
    }
}
