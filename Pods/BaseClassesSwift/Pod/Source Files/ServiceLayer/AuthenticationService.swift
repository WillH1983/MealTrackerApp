//
//  AuthenticationService.swift
//  BaseClasses
//
//  Created by William Hindenburg on 7/30/15.
//  Copyright © 2015 William Hindenburg. All rights reserved.
//

import Foundation

public class AuthenticationService: BaseClassesService {
    var registeringUser = false
    
    public init () {
        
    }
    
    public func registerUser(userObject:RegisterUser, withSuccessBlock:(User -> Void), andError:(NSError -> Void)) -> Void {
        self.registeringUser = true
        BaseClassesServiceClient().postObject(userObject, andService: self, successBlock: { (object:User) -> Void in
            self.registeringUser = false
            self.loginUser(userObject, withSuccessBlock: { (loginObject) in
                loginObject.username = userObject.username
                withSuccessBlock(loginObject)
            }, andError: { (error) in
                    
            })
            
        }) { (error) -> Void in
            andError(error)
        }
    }
    
    public func loginUser(userObject:RegisterUser, withSuccessBlock:(User -> Void), andError:(NSError -> Void)) {
        BaseClassesServiceClient().postObject(userObject, andService: self, successBlock: { (object:User) -> Void in
            withSuccessBlock(object)
        }) { (error) -> Void in
            andError(error)
        }
    }
    
    public var serviceURL:String {
        if self.registeringUser {
            return "/register"
        } else {
            return "/login"
        }
        
    }

}
