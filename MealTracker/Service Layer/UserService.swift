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
    
    func updatePoints(points:Points, successBlock:(Points -> Void), errorBlock:(NSError -> Void)) {
        BaseClassesServiceClient().postObject(points, andService: self, successBlock: { (points:Points) -> Void in
            successBlock(points)
        }) { (error) -> Void in
            errorBlock(error)
        }
    }
    
    func getPoints(successBlock:(Points -> Void), errorBlock:(NSError -> Void)) {
        BaseClassesServiceClient().getObject(self, successBlock: { (points:Points) in
            successBlock(points)
        }) { (error) in
            errorBlock(error)
        }
    }
    
    var serviceURL:String {
        return "/weeklypoints"
    }
}
