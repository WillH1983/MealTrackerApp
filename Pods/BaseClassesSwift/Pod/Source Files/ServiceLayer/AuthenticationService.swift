//
//  AuthenticationService.swift
//  BaseClasses
//
//  Created by William Hindenburg on 7/30/15.
//  Copyright © 2015 William Hindenburg. All rights reserved.
//

import Foundation

public class AuthenticationService: BaseClassesService {
    private var params = [String: String]()
    private var loggingIn = false
    
    public init () {
        
    }
    
    public func registerUser(userObject:RegisterUser, withSuccessBlock:(User -> Void), andError:(NSError -> Void)) -> Void {
        BaseClassesServiceClient().postObject(userObject, andService: self, successBlock: { (object:User) -> Void in
            object.username = userObject.username
            withSuccessBlock(object)
        }) { (error) -> Void in
            andError(error)
        }
    }
    
    public func loginUser(userObject:RegisterUser, withSuccessBlock:(User -> Void), andError:(NSError -> Void)) {
        self.params = ["username": userObject.username, "password": userObject.password]
        self.loggingIn = true
        BaseClassesServiceClient().getObject(self, successBlock: { (object:User) -> Void in
            withSuccessBlock(object)
        }) { (error) -> Void in
            andError(error)
        }
    }
    
    public var serviceURL:String {
        if self.loggingIn {
            return "/1/login"
        } else {
            return "/1/users"
        }
    }
    
    public var requestQueryParameters:Dictionary<String, String>? {
        return self.params
    }
}
