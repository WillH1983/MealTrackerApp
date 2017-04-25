//
//  DeleteMealServiceSwift.swift
//  MealTracker
//
//  Created by William Hindenburg on 1/11/16.
//
//

import Foundation
import BaseClassesSwift

class DeleteMealServiceSwift: NSObject, BaseClassesService {
    func removeMeals(_ meals:RemoveMeals, successBlock:@escaping ((Void) -> Void), errorBlock:@escaping ((NSError) -> Void)) {
        BaseClassesServiceClient().postObject(meals, andService: self, successBlock: { (object:BatchResponse) -> Void in
            self.cleanupMealArrayAfterServiceCall(meals.requests)
            successBlock()
        }) { (error) -> Void in
            self.cleanupMealArrayAfterServiceCall(meals.requests)
            errorBlock(error)
        }
    }
    
    func removeMeal(_ meal:Meal, successBlock:((Void) -> Void), errorBlock:((NSError) -> Void)) {
        let meals = RemoveMeals()
        meals.requests = [meal]
        self.removeMeals(meals, successBlock: successBlock, errorBlock: errorBlock)
    }
    
    func cleanupMealArrayAfterServiceCall(_ meals:[Meal]) {
        for meal in meals {
            self.cleanupMealAfterServiceCall(meal)
        }
    }
    
    func cleanupMealAfterServiceCall(_ meal:Meal) {

    }
    
    func deletePath(_ objectId:String) -> String {
        return "/1/classes/Meal/" + objectId
    }
    
    var serviceURL:String {
        return "/1/batch"
    }
}
