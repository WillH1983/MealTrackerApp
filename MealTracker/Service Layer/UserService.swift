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
    
    func updateUser(_ user:User, successBlock:@escaping ((User) -> Void), errorBlock:@escaping ((NSError) -> Void)) {
        self.objectId = user.objectId
        BaseClassesServiceClient().putObject(user, andService: self, successBlock: { (user:User) -> Void in
            successBlock(user)
        }) { (error) -> Void in
            errorBlock(error)
        }
    }
    
    func updatePoints(_ points:Points, successBlock:@escaping ((Points) -> Void), errorBlock:@escaping ((NSError) -> Void)) {
        BaseClassesServiceClient().postObject(points, andService: self, successBlock: { (points:Points) -> Void in
            successBlock(points)
        }) { (error) -> Void in
            errorBlock(error)
        }
    }
    
    func getPoints(_ successBlock:@escaping ((Points) -> Void), errorBlock:@escaping ((NSError) -> Void)) {
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
