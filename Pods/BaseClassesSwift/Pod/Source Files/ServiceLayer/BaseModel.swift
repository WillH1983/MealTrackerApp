//
//  ScrubTechBaseModel.swift
//  Scrub Tech
//
//  Created by William Hindenburg on 11/14/15.
//  Copyright © 2015 Robot Woods, LLC. All rights reserved.
//

import UIKit
import ObjectMapper

public enum ScrubTechServiceErrorCode {
    case noError
    case activationKeyExpired
    case activationKeyIncorrect
    case activationKeyLocked
    case userInputInvalid
    case genericError
}

open class BaseModel:NSObject, Mappable {
    

    open var objectId = ""
    open var objectType = "Pointer"
    
    public override init() {
        super.init()
    }
    
    
    required public init?(map: Map) {
        
    }
    
    open func mapping(map: Map) {
        objectType <- map["__type"]
        objectId <- map["objectId"]
    }
}
