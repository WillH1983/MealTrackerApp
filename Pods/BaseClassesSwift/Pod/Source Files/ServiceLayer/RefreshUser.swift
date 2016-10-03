//
//  User.swift
//  BaseClasses
//
//  Created by William Hindenburg on 8/2/15.
//  Copyright © 2015 William Hindenburg. All rights reserved.
//

import UIKit
import ObjectMapper

public class RefreshUser: BaseModel {
    public var refreshToken = ""
    
    override public init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    public override func mapping(map: Map) {
        refreshToken <- map["RefreshToken"]
    }
}
