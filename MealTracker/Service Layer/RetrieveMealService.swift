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
    func retrieveMeals(_ successBlock:@escaping ((Array<Meal>) -> Void), errorBlock:@escaping ((NSError) -> Void)) -> Void {
        let serviceClient = BaseClassesServiceClient()
        serviceClient.getObjects(self, successBlock: { (object:[Meal]) -> Void in
            successBlock(object)
        }) { (error) -> Void in
            errorBlock(error)
        }
    }
    
    var serviceURL:String {
        return "/meals"
    }
    
    var rootKeyPath:String {
        return "items"
    }
}
