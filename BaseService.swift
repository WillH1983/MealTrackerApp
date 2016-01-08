//
//  BaseService.swift
//  BaseClasses
//
//  Created by William Hindenburg on 8/2/15.
//  Copyright © 2015 William Hindenburg. All rights reserved.
//

import UIKit

public class SwiftBaseService: NSObject {
    public func baseURL() -> String {
        return "https://api.parse.com"
    }
    
    public func parameters() -> [String: AnyObject]? {
        return nil
    }
    
    public func rootRequestKeyPath() -> String? {
        return nil
    }
}
