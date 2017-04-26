//
//  BatchResponse.swift
//  MealTracker
//
//  Created by William Hindenburg on 1/16/16.
//
//

import Foundation
import ObjectMapper
import BaseClassesSwift

class BatchResponse: BaseModel {
    var successArray = [Dictionary<String, AnyObject>]()
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        successArray <- map["success"]

    }
}
