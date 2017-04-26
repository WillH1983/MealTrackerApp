//
//  NewMeal.swift
//  MealTracker
//
//  Created by William Hindenburg on 1/12/16.
//
//

import Foundation
import BaseClassesSwift
import ObjectMapper

open class NewMeal: BaseModel {
    var calories = NSDecimalNumber()
    var carbs = NSDecimalNumber()
    var dietaryFiber = NSDecimalNumber()
    var mealDescription = ""
    var name = ""
    var protein = NSDecimalNumber()
    var servingSize = ""
    var totalFat = NSDecimalNumber()
    var weightWatchersPlusPoints = NSDecimalNumber()
    
    override init() {
        super.init()
    }
    
    required public init?(map: Map) {
        super.init(map: map)
    }
    
    override open func mapping(map: Map) {
        calories <- (map["Calories"], BaseClassesDecimalNumberTransform())
        carbs <- (map["Carbs"], BaseClassesDecimalNumberTransform())
        dietaryFiber <- (map["DietaryFiber"], BaseClassesDecimalNumberTransform())
        mealDescription <- map["MealDescription"]
        name <- map["Name"]
        protein <- (map["Protein"], BaseClassesDecimalNumberTransform())
        servingSize <- map["ServingSize"]
        totalFat <- (map["TotalFat"], BaseClassesDecimalNumberTransform())
        weightWatchersPlusPoints <- (map["WeightWatchersPlusPoints"], BaseClassesDecimalNumberTransform())
    }
}
