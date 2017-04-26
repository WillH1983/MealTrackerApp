//
//  RemoveMeal.swift
//  MealTracker
//
//  Created by William Hindenburg on 1/10/16.
//
//

import Foundation
import BaseClassesSwift
import ObjectMapper

open class RemoveMealsEaten: BaseModel {
    var requests = [MealEaten]()
    
    override init() {
        super.init()
    }
    
    required public init?(map: Map) {
        super.init(map: map)
    }
    
    override open func mapping(map: Map) {
        super.mapping(map: map)
        requests <- map["requests"]
    }
}
