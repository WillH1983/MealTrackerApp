//
//  ServiceErrors.swift
//  BaseClasses
//
//  Created by William Hindenburg on 8/2/15.
//  Copyright © 2015 William Hindenburg. All rights reserved.
//

import Foundation

enum SwiftServiceErrorCode: Int {
    case maintenanceMode
    case forceUpgrade
    case generic
}

let kMaintenanceModeErrorTitleKey = "maintModeErrorTitle"
let kForceUpgradeTitleKey = "forceUpgradeTitle"
let kForceUpgradeURL = "forceUpgradeURL"
