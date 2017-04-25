//
//  SaveMealServiceSwift.swift
//  MealTracker
//
//  Created by William Hindenburg on 1/12/16.
//
//

import Foundation
import BaseClassesSwift

class SaveMealServiceSwift: BaseClassesService {
    var isUpdatingMeal = false
    var mealObjectId = ""
    
    func saveMeal(_ meal:Meal, successBlock:@escaping ((Meal) -> Void), errorBlock:@escaping ((NSError) -> Void)) {
        BaseClassesServiceClient().postObject(self.createNewMealFrom(meal), andService: self, successBlock: { (meal:Meal) -> Void in
            successBlock(meal)
        }) { (error) -> Void in
            errorBlock(error)
        }
    }
    
    func updateMeal(_ meal:Meal, successBlock:@escaping ((Void) -> Void), errorBlock:@escaping ((NSError) -> Void)) {
        self.isUpdatingMeal = true
        self.mealObjectId = meal.objectId
        BaseClassesServiceClient().putObject(self.createNewMealFrom(meal), andService: self, successBlock: { (meal:Meal) -> Void in
            successBlock()
        }) { (error) -> Void in
            errorBlock(error)
        }
    }
    
    func createNewMealFrom(_ meal:Meal) -> NewMeal {
        let postMeal = NewMeal()
        postMeal.calories = meal.calories
        postMeal.carbs = meal.carbs
        postMeal.dietaryFiber = meal.dietaryFiber
        postMeal.mealDescription = meal.mealDescription
        postMeal.name = meal.name
        postMeal.protein = meal.protein
        postMeal.servingSize = meal.servingSize
        postMeal.totalFat = meal.totalFat
        postMeal.weightWatchersPlusPoints = meal.weightWatchersPlusPoints
        return postMeal
    }
    
    var serviceURL:String {
        if self.isUpdatingMeal {
            return "/1/classes/Meal/\(self.mealObjectId)"
        } else {
            return "/meals"
        }
    }
}
