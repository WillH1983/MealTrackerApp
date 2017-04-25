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

@objc class Points: BaseModel {
    var dateEaten = NSDate()
    var points = "0"
    
    override init() {
        super.init()
    }
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        points <- map ["points"]
    }
}
