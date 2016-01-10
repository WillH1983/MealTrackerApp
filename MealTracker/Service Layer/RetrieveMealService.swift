//
//  RetrieveMealService.swift
//  MealTracker
//
//  Created by William Hindenburg on 1/10/16.
//
//

import Foundation
import BaseClassesSwift

class RetrieveMealService: NSObject, BaseClassesService {
    func retrieveMeals(successBlock:(Array<Meal> -> Void), errorBlock:(NSError -> Void)) -> Void {
        let serviceClient = BaseClassesServiceClient()
        serviceClient.getObjects(self, successBlock: { (object:[Meal]) -> Void in
            successBlock(object)
        }) { (error) -> Void in
            errorBlock(error)
        }
    }
    
    var serviceURL:String {
        return "/1/classes/Meal"
    }
    
    var rootKeyPath:String {
        return "results"
    }
}
