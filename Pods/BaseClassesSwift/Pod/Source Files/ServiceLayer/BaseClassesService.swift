//
//  ScrubTechService.swift
//  Scrub Tech
//
//  Created by William Hindenburg on 11/13/15.
//  Copyright © 2015 Robot Woods, LLC. All rights reserved.
//

import UIKit
import Alamofire

public protocol BaseClassesService: URLConvertible {
    var serviceURL:String {get}
    var baseURL:String {get}
    var rootRequestKeyPath:String? {get}
    var rootKeyPath:String {get}
    var requestQueryParameters:Dictionary<String, String>? {get}
    func asURL() throws -> URL
}

extension BaseClassesService {
    public var baseURL:String {
        return "https://m4cnztuipf.execute-api.us-east-1.amazonaws.com/prod"
    }
    
    public func asURL() throws -> URL {
        return URL(string: self.URLString)!;
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
