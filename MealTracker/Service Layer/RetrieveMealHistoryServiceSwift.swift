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
    
    func loadMealHistory(user:User, successBlock:(Array<MealEaten> -> Void), errorBlock:(NSError -> Void)) -> Void {
        let serviceClient = BaseClassesServiceClient()
        serviceClient.getObjects(self, successBlock: { (object:[MealEaten]) -> Void in
            successBlock(object)
        }) { (error) -> Void in
            errorBlock(error)
        }
    }
    
    var serviceURL:String {
        return "/mealseaten"
    }
    
    var rootKeyPath:String {
        return "items"
    }
}
