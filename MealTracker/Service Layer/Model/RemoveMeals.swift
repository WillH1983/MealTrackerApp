//
//  RemoveMeals.swift
//  MealTracker
//
//  Created by William Hindenburg on 1/11/16.
//
//

import Foundation
import BaseClassesSwift
import ObjectMapper

class RemoveMeals: BaseModel {
    var requests = [Meal]()
    
    override init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    override public func mapping(map: Map) {
        super.mapping(map)
        requests <- map["requests"]
    }
}