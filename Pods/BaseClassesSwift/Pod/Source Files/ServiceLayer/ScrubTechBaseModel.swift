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

class ScrubTechBaseModel:NSObject, Mappable {
    
    var id = 0
    
    var error = ""
    var result = ""
    
    lazy var errorType:ScrubTechServiceErrorCode = {
        if self.result == "fail" {
            if self.error == "input" {
                return ScrubTechServiceErrorCode.UserInputInvalid
            } else if self.error == "time" {
                return ScrubTechServiceErrorCode.ActivationKeyExpired
            } else if self.error == "key" {
                return ScrubTechServiceErrorCode.ActivationKeyIncorrect
            } else if self.error == "lock" {
                return ScrubTechServiceErrorCode.ActivationKeyLocked
            } else {
                return ScrubTechServiceErrorCode.GenericError
            }
        } else {
            return ScrubTechServiceErrorCode.NoError
        }
        
        }()
    
    override init() {
        
    }
    
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        result <- map["result"]
        error <- map["error"]
    }
}
