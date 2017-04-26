//
//  MealEaten.swift
//  MealTracker
//
//  Created by William Hindenburg on 1/9/16.
//
//

import UIKit
import BaseClassesSwift
import ObjectMapper

class MealEatenPost: BaseModel {
    var dateEaten = Date()
    var meal = Meal()
    var mealObjectId = 0
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        dateEaten <- (map["DateEaten"], BaseClassesDateTransform())
        mealObjectId = meal.newObjectId
        mealObjectId <- map ["Meal"]
    }
}
