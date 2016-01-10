//
//  UserService.swift
//  MealTracker
//
//  Created by William Hindenburg on 1/10/16.
//
//

import UIKit
import BaseClassesSwift

class UserService: NSObject, BaseClassesService {
    var objectId = ""
    
    func updateUser(user:User, successBlock:(User -> Void), errorBlock:(NSError -> Void)) {
        self.objectId = user.objectId
        BaseClassesServiceClient().putObject(user, andService: self, successBlock: { (user:User) -> Void in
            successBlock(user)
        }) { (error) -> Void in
            errorBlock(error)
        }
    }
    
    var serviceURL:String {
        return "/1/users/" + self.objectId
    }
}
