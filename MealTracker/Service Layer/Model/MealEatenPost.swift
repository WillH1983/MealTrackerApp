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

@objc class MealEatenPost: BaseModel {
    var dateEaten = NSDate()
    var meal = Meal()
    var mealObjectId = 0
    
    override init() {
        super.init()
    }
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        dateEaten <- (map["DateEaten"], BaseClassesDateTransform())
        mealObjectId = meal.newObjectId
        mealObjectId <- map ["meal"]
    }
}
