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
    var refreshingToken = false
    
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
            object.username = userObject.username
            withSuccessBlock(object)
        }) { (error) -> Void in
            andError(error)
        }
    }
    
    public func refreshUser(refreshObject:RefreshUser, withSuccessBlock:(User -> Void), andError:(NSError -> Void)) {
        self.refreshingToken = true
        BaseClassesServiceClient().postObject(refreshObject, andService: self, successBlock: { (object:User) -> Void in
            var userObject = User.persistentUserObject()
            userObject.idToken = object.idToken
            withSuccessBlock(userObject)
        }) { (error) -> Void in
            andError(error)
        }
    }
    
    public var serviceURL:String {
        if refreshingToken == false {
            if self.registeringUser {
                return "/register"
            } else {
                return "/login"
            }
        } else {
            return "/refresh"
        }
        
        
    }

}
