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
    
    
    public func registerUser(userObject:User, withSuccessBlock:(User -> Void), andError:(NSError -> Void)) -> Void {
//        ServiceClient().postObject(userObject, andService: self, withSuccessBlock: { (result: RKMappingResult) -> Void in
//            if let mappedUserObject = result.firstObject() as? User {
//                withSuccessBlock(mappedUserObject)
//            } else {
//                andError(NSError(domain: "BaseClasses", code: 1, userInfo: nil))
//            }
//        }) { (errorObject) -> Void in
//            andError(errorObject)
//        }
    }
    
    public func loginUser(userObject:User, withSuccessBlock:(User -> Void), andError:(NSError -> Void)) {
//        self.params = ["username": userObject.username, "password": userObject.password]
//        self.loggingIn = true
//        ServiceClient().getForService(self, withSuccess: { (result) -> Void in
//            if let mappedUserObject = result.firstObject() as? User {
//                withSuccessBlock(mappedUserObject)
//            } else {
//                andError(NSError(domain: "BaseClasses", code: 1, userInfo: nil))
//            }
//        }) { (error) -> Void in
//            andError(error)
//        }
    }
    
    public var serviceURL:String {
        if self.loggingIn {
            return "/1/login"
        } else {
            return "/1/users"
        }
    }
    
    public func rootKeyPath() -> String? {
        return nil
    }
    
    public func parameters() -> [NSObject : AnyObject]? {
        return self.params
    }
    
//    public func mappingProvider() -> RKObjectMapping {
//        let mapping = RKObjectMapping(forClass: User.self)
//        mapping.addAttributeMappingsFromDictionary(["objectId": "objectId"])
//        mapping.addAttributeMappingsFromDictionary(["sessionToken": "sessionToken"])
//        mapping.addAttributeMappingsFromDictionary(["username": "username"])
//        mapping.addAttributeMappingsFromDictionary(["pointsPerWeek": "pointsPerWeek"])
//        
//        return mapping
//    }
//    
//    public func serializedMappingProvider() -> RKObjectMapping {
//        let serialMapping = RKObjectMapping(forClass: User.self)
//        serialMapping.addAttributeMappingsFromDictionary(["username": "username"])
//        serialMapping.addAttributeMappingsFromDictionary(["password": "password"])
//        return serialMapping
//    }
}
