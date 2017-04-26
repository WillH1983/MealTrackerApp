//
//  RegisterUser.swift
//  Pods
//
//  Created by William Hindenburg on 1/8/16.
//
//

import UIKit
import ObjectMapper

open class RegisterUser: BaseModel {
    open var username = ""
    open var password = ""
    open var email = ""
    
    open var className: String {
        get {
            return "_User"
        }
    }
        
    override public init() {
        super.init()
    }
    
    required public init?(map: Map) {
        super.init(map: map)
    }
    
    open override func mapping(map: Map) {
        username <- map["username"]
        password <- map["password"]
        email <- map["email"]
    }
}
