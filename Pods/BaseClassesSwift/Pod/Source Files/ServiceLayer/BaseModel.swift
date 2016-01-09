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
    case NoError
    case ActivationKeyExpired
    case ActivationKeyIncorrect
    case ActivationKeyLocked
    case UserInputInvalid
    case GenericError
}

public class BaseModel:NSObject, Mappable {
    

    public var objectId = ""
    public var objectType = "Pointer"
    
    public override init() {
        super.init()
    }
    
    
    required public init?(_ map: Map) {
        
    }
    
    public func mapping(map: Map) {
        objectType <- map["__type"]
        objectId <- map["objectId"]
    }
}
