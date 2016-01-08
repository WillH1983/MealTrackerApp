//
//  User.swift
//  BaseClasses
//
//  Created by William Hindenburg on 8/2/15.
//  Copyright © 2015 William Hindenburg. All rights reserved.
//

import UIKit

public class User: NSObject {
    public var username = ""
    public var password = ""
    public var objectId = ""
    public var sessionToken = ""
    public var pointsPerWeek:NSNumber = 0
    
    public var className: String {
        get {
            return "_User"
        }
    }
    
    public var objectType: String {
        get {
            return "Pointer"
        }
    }
    
    public class func persistentUserObject() -> User {
        if let userDictionary = NSUserDefaults.standardUserDefaults().objectForKey("userData") as? [String: AnyObject] {
            return self.userObjectFromDictionary(userDictionary)
        } else {
            return User()
        }
        
    }
    
    public class func deleteUser() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.removeObjectForKey("userData")
        userDefaults.synchronize()
    }
    
    public func save() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(self.dictionaryRepresentation(), forKey: "userData")
        userDefaults.synchronize()
    }
    
    private func dictionaryRepresentation() -> [String: AnyObject] {
        return ["username": self.username, "objectId": self.objectId, "sessionToken": self.sessionToken, "pointsPerWeek": self.pointsPerWeek]
    }
    
    private class func userObjectFromDictionary(userDictionary: [String: AnyObject]) -> User {
        let user = User()
        user.username = userDictionary["username"] as? String ?? ""
        user.objectId = userDictionary["objectId"] as? String ?? ""
        user.sessionToken = userDictionary["sessionToken"] as? String ?? ""
        user.pointsPerWeek = userDictionary["pointsPerWeek"] as? NSNumber ?? 0
        return user
    }
    
    
}
