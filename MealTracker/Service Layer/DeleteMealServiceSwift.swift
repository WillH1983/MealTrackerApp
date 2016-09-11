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
    func removeMeals(meals:RemoveMeals, successBlock:(Void -> Void), errorBlock:(NSError -> Void)) {
        for meal in meals.requests {
            meal.method = "DELETE"
            meal.path = self.deletePath(meal.objectId)
        }
        BaseClassesServiceClient().postObject(meals, andService: self, successBlock: { (object:BatchResponse) -> Void in
            self.cleanupMealArrayAfterServiceCall(meals.requests)
            successBlock()
        }) { (error) -> Void in
            self.cleanupMealArrayAfterServiceCall(meals.requests)
            errorBlock(error)
        }
    }
    
    func removeMeal(meal:Meal, successBlock:(Void -> Void), errorBlock:(NSError -> Void)) {
        let meals = RemoveMeals()
        meals.requests = [meal]
        self.removeMeals(meals, successBlock: successBlock, errorBlock: errorBlock)
    }
    
    func cleanupMealArrayAfterServiceCall(meals:[Meal]) {
        for meal in meals {
            self.cleanupMealAfterServiceCall(meal)
        }
    }
    
    func cleanupMealAfterServiceCall(meal:Meal) {
        meal.method = nil
        meal.path = nil
    }
    
    func deletePath(objectId:String) -> String {
        return "/1/classes/Meal/" + objectId
    }
    
    var serviceURL:String {
        return "/1/batch"
    }
}
