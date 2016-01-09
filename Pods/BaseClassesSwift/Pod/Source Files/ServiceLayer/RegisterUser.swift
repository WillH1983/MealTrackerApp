//
//  RegisterUser.swift
//  Pods
//
//  Created by William Hindenburg on 1/8/16.
//
//

import UIKit
import ObjectMapper

public class RegisterUser: BaseModel {
    public var username = ""
    public var password = ""
    
    public var className: String {
        get {
            return "_User"
        }
    }
    
    public var objectType: String {
        get {
            return "Pointer"
        }
    }
    
    override public init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    public override func mapping(map: Map) {
        username <- map["username"]
        password <- map["password"]
    }
}
