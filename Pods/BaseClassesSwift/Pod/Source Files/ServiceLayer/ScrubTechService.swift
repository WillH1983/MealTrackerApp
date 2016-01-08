//
//  ScrubTechService.swift
//  Scrub Tech
//
//  Created by William Hindenburg on 11/13/15.
//  Copyright © 2015 Robot Woods, LLC. All rights reserved.
//

import UIKit
import Alamofire

protocol ScrubTechService: URLStringConvertible {
    var serviceURL:String {get}
    var baseURL:String {get}
    var rootRequestKeyPath:String {get}
    var rootKeyPath:String {get}
}

extension ScrubTechService {
    var baseURL:String {
        return "https://www.scrub-tech.com"
    }
    
    var URLString:String {
        return self.baseURL + self.serviceURL
    }
    
    var rootRequestKeyPath:String {
        return "request"
    }
    
    var rootKeyPath:String {
        return "object"
    }
}
