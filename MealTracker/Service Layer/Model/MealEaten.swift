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

class MealEaten: BaseModel {
    var dateEaten = Date()
    var meal = Meal()
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        dateEaten <- (map["DateEaten"], BaseClassesDateTransform())
        meal <- map ["meal"]
    }
}
