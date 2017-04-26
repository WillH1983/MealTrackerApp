//
//  Points.swift
//  MealTracker
//
//  Created by William Hindenburg on 12/10/16.
//
//

import UIKit
import BaseClassesSwift
import ObjectMapper

class Points: BaseModel {
    var dateEaten = Date()
    var points = "0"
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        points <- map ["points"]
    }
}
