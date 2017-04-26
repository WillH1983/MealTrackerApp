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
    func removeMealsEaten(_ mealsEaten:RemoveMealsEaten, successBlock:@escaping ((Void) -> Void), errorBlock:@escaping ((NSError) -> Void)) {
        for mealEaten in mealsEaten.requests {
        }
        BaseClassesServiceClient().postObject(mealsEaten, andService: self, successBlock: { (object) -> Void in
            self.cleanupMealArrayAfterServiceCall(mealsEaten.requests)
            successBlock()
        }) { (error) -> Void in
            self.cleanupMealArrayAfterServiceCall(mealsEaten.requests)
            errorBlock(error)
        }
        
    }
    
    func removeMealEaten(_ mealEaten:MealEaten, successBlock:@escaping ((Void) -> Void), errorBlock:@escaping ((NSError) -> Void)) {
        let meals = RemoveMealsEaten()
        meals.requests = [mealEaten]
        self.removeMealsEaten(meals, successBlock: successBlock, errorBlock: errorBlock)
    }
    
    var serviceURL:String {
        return "/1/batch"
    }
    
    func cleanupMealArrayAfterServiceCall(_ meals:[MealEaten]) {
        for meal in meals {
            self.cleanupMealAfterServiceCall(meal)
        }
    }
    
    func cleanupMealAfterServiceCall(_ meal:MealEaten) {

    }
    
    
    func deletePath(_ objectId:String) -> String {
        return "/1/classes/MealEaten/" + objectId
    }
}
