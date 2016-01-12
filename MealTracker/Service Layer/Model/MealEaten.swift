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

@objc class MealEaten: BaseModel {
    var dateEaten = NSDate()
    var user = User()
    var meal = Meal()
    var method:String?
    var path:String?

    override init() {
        super.init()
    }
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        dateEaten <- (map["dateEaten"], BaseClassesDateTransform())
        user <- map ["user"]
        meal <- map ["meal"]
        objectId <- map["objectId"]
        method <- map["method"]
        path <- map["path"]
    }
}
