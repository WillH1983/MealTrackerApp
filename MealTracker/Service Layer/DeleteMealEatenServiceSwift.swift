//
//  DeleteMealEatenServiceSwift.swift
//  MealTracker
//
//  Created by William Hindenburg on 1/10/16.
//
//

import Foundation
import BaseClassesSwift

class DeleteMealEatenServiceSwift: NSObject, BaseClassesService {
    func removeMealsEaten(mealsEaten:RemoveMealsEaten, successBlock:(Void -> Void), errorBlock:(NSError -> Void)) {
        for mealEaten in mealsEaten.requests {
            mealEaten.method = "DELETE"
            mealEaten.path = self.deletePath(mealEaten.objectId)
        }
        BaseClassesServiceClient().postObject(mealsEaten, andService: self, successBlock: { (object) -> Void in
            self.cleanupMealArrayAfterServiceCall(mealsEaten.requests)
            successBlock()
        }) { (error) -> Void in
            self.cleanupMealArrayAfterServiceCall(mealsEaten.requests)
            errorBlock(error)
        }
        
    }
    
    func removeMealEaten(mealEaten:MealEaten, successBlock:(Void -> Void), errorBlock:(NSError -> Void)) {
        let meals = RemoveMealsEaten()
        meals.requests = [mealEaten]
        self.removeMealsEaten(meals, successBlock: successBlock, errorBlock: errorBlock)
    }
    
    var serviceURL:String {
        return "/1/batch"
    }
    
    func cleanupMealArrayAfterServiceCall(meals:[MealEaten]) {
        for meal in meals {
            self.cleanupMealAfterServiceCall(meal)
        }
    }
    
    func cleanupMealAfterServiceCall(meal:MealEaten) {
        meal.method = nil
        meal.path = nil
    }
    
    
    func deletePath(objectId:String) -> String {
        return "/1/classes/MealEaten/" + objectId
    }
}
