//
//  ScrubTechService.swift
//  Scrub Tech
//
//  Created by William Hindenburg on 11/13/15.
//  Copyright © 2015 Robot Woods, LLC. All rights reserved.
//

import UIKit
import Alamofire

public protocol BaseClassesService: URLStringConvertible {
    var serviceURL:String {get}
    var baseURL:String {get}
    var rootRequestKeyPath:String {get}
    var rootKeyPath:String {get}
}

extension BaseClassesService {
    public var baseURL:String {
        return "https://www.scrub-tech.com"
    }
    
    public var URLString:String {
        return self.baseURL + self.serviceURL
    }
    
    public var rootRequestKeyPath:String {
        return "request"
    }
    
    public var rootKeyPath:String {
        return "object"
    }
}
