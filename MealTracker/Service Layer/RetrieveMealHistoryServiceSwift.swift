//
//  RetrieveMealHistoryServiceSwift.swift
//  MealTracker
//
//  Created by William Hindenburg on 1/9/16.
//
//

import UIKit
import BaseClassesSwift

class RetrieveMealHistoryServiceSwift:NSObject, BaseClassesService {
    var user:User!
    
    func loadMealHistory(user:User, successBlock:(Array<MealEaten> -> Void), errorBlock:(NSError -> Void)) -> Void {
        self.user = user
        let serviceClient = BaseClassesServiceClient()
        serviceClient.getObjects(self, successBlock: { (object:[MealEaten]) -> Void in
            successBlock(object)
        }) { (error) -> Void in
            errorBlock(error)
        }
    }
    
    var serviceURL:String {
        return "/1/classes/MealEaten"
    }
    
    var rootRequestKeyPath:String? {
        return "results"
    }
    
    var requestQueryParameters:Dictionary<String, String>? {
        var query = "{\"user\":{\"__type\": \"Pointer\", \"className\": \"_User\",\"objectId\": \"\(self.user.objectId)\"}}"
        query = query.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        let queryDictionary = ["where":query, "include":"meal"]
        return queryDictionary
    }
}
