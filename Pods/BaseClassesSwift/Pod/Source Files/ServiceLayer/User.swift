//
//  User.swift
//  BaseClasses
//
//  Created by William Hindenburg on 8/2/15.
//  Copyright © 2015 William Hindenburg. All rights reserved.
//

import UIKit
import ObjectMapper

open class User: BaseModel {
    open var username = ""
    open var password = ""
    open var refreshToken = ""
    open var idToken = ""
    open var pointsPerWeek:NSNumber = 0
    
    override public init() {
        super.init()
    }
    
    required public init?(map: Map) {
        super.init(map: map)
    }
    
    open class func persistentUserObject() -> User {
        if let userDictionary = UserDefaults.standard.object(forKey: "userData") as? [String: AnyObject] {
            return self.userObjectFromDictionary(userDictionary)
        } else {
            return User()
        }
        
    }
    
    open class func deleteUser() {
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: "userData")
        userDefaults.synchronize()
    }
    
    open func save() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(self.dictionaryRepresentation(), forKey: "userData")
        userDefaults.synchronize()
    }
    
    fileprivate func dictionaryRepresentation() -> [String: AnyObject] {
        return ["username": self.username as AnyObject, "objectId": self.objectId as AnyObject, "sessionToken": self.refreshToken as AnyObject, "pointsPerWeek": self.pointsPerWeek, "idToken": self.idToken as AnyObject]
    }
    
    fileprivate class func userObjectFromDictionary(_ userDictionary: [String: AnyObject]) -> User {
        let user = User()
        user.username = userDictionary["username"] as? String ?? ""
        user.objectId = userDictionary["objectId"] as? String ?? ""
        user.refreshToken = userDictionary["sessionToken"] as? String ?? ""
        user.pointsPerWeek = userDictionary["pointsPerWeek"] as? NSNumber ?? 0
        user.idToken = userDictionary["idToken"] as? String ?? ""
        return user
    }
    
    open override func mapping(map: Map) {
        super.mapping(map: map)
        refreshToken <- map["RefreshToken"]
        username <- map["username"]
        pointsPerWeek <- map["pointsPerWeek"]
        password <- map["password"]
        idToken <- map["IdToken"]
    }
}
