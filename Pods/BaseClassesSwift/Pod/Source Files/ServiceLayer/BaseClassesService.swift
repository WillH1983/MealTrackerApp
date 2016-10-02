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
    var rootRequestKeyPath:String? {get}
    var rootKeyPath:String {get}
    var requestQueryParameters:Dictionary<String, String>? {get}
}

extension BaseClassesService {
    public var baseURL:String {
        return "https://cognito-identity.us-east-1.amazonaws.com"
    }
    
    public var URLString:String {
        var urlString = self.baseURL + self.serviceURL
        if self.requestQueryParameters != nil {
            var queryString = "?"
            for (key, value) in self.requestQueryParameters! {
                queryString = queryString + key + "=" + value + "&"
            }
            urlString = urlString + queryString
            urlString = String(urlString.characters.dropLast())
        }
        return urlString
    }
    
    public var rootRequestKeyPath:String? {
        return nil
    }
    
    public var rootKeyPath:String {
        return ""
    }
    
    public var requestQueryParameters:Dictionary<String, String>? {
        return nil
    }
}
