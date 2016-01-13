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

public class NewMeal: BaseModel {
    var calories = NSDecimalNumber()
    var carbs = NSDecimalNumber()
    var dietaryFiber = NSDecimalNumber()
    var mealDescription = ""
    var name = ""
    var protein = NSDecimalNumber()
    var servingSize = ""
    var totalFat = NSDecimalNumber()
    var weightWatchersPlusPoints = NSDecimalNumber()
    var whenEaten = NSSet()
    
    override init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    override public func mapping(map: Map) {
        calories <- (map["calories"], BaseClassesDecimalNumberTransform())
        carbs <- (map["carbs"], BaseClassesDecimalNumberTransform())
        dietaryFiber <- (map["dietaryFiber"], BaseClassesDecimalNumberTransform())
        mealDescription <- map["mealDescription"]
        name <- map["name"]
        protein <- (map["protein"], BaseClassesDecimalNumberTransform())
        servingSize <- map["servingSize"]
        totalFat <- (map["totalFat"], BaseClassesDecimalNumberTransform())
        weightWatchersPlusPoints <- (map["weightWatchersPlusPoints"], BaseClassesDecimalNumberTransform())
        whenEaten <- map["whenEaten"]
    }
}
