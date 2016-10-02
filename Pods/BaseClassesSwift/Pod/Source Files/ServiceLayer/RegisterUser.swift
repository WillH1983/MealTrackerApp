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
    public var ClientId = "3g30ulm3nd6so3ee0pofaobs6g"
    private var UserAttributes = Array<Dictionary<String, AnyObject>>()
    
    public var className: String {
        get {
            return "_User"
        }
    }
        
    override public init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    public override func mapping(map: Map) {
        username <- map["Username"]
        password <- map["Password"]
        let dictionary = ["email": username]
        UserAttributes = [dictionary]
        UserAttributes <- map["UserAttributes"]
    }
}
