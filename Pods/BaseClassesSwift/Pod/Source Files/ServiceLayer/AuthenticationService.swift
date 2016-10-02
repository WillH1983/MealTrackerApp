//
//  AuthenticationService.swift
//  BaseClasses
//
//  Created by William Hindenburg on 7/30/15.
//  Copyright © 2015 William Hindenburg. All rights reserved.
//

import Foundation

public class AuthenticationService: BaseClassesService {
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
        BaseClassesServiceClient().postObject(userObject, andService: self, successBlock: { (object:User) -> Void in
            withSuccessBlock(object)
        }) { (error) -> Void in
            andError(error)
        }
    }
    
    public var serviceURL:String {
        return "/us-east-1_gdE6wH38Z/SignUp"
    }

}
