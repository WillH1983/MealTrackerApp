//
//  BaseTableViewController.swift
//  BaseClasses
//
//  Created by William Hindenburg on 8/2/15.
//  Copyright © 2015 William Hindenburg. All rights reserved.
//

import UIKit

public class SwiftBaseTableViewController: UITableViewController {
    
    /**
        Call this method when an error has occured during a service call
        - Parameter: error The error that was returned from a service call
        - Parameter: retryBlock The block that will be executed if the user taps "Retry"
    */
    public func showError(error:NSError, withRetryBlock:(Void -> Void)) {
        if User.persistentUserObject().sessionToken.isEmpty == false {
            let errorMessage = error.localizedDescription
            var title = ""
            var style = UIAlertControllerStyle.ActionSheet
            
            if error.code == SwiftServiceErrorCode.ForceUpgrade.rawValue {
                title = error.userInfo[kForceUpgradeTitleKey] as? String ?? "Error"
                style = UIAlertControllerStyle.Alert
                
            } else if error.code == SwiftServiceErrorCode.MaintenanceMode.rawValue {
                title = error.userInfo[kMaintenanceModeErrorTitleKey] as? String ?? "Error"
            }
            
            let errorAlert = UIAlertController(title: title, message: errorMessage, preferredStyle: style)
            
            if error.code != SwiftServiceErrorCode.ForceUpgrade.rawValue {
                errorAlert.addAction(UIAlertAction(title: "Retry", style: UIAlertActionStyle.Destructive, handler: { (action) -> Void in
                    withRetryBlock()
                }))
            } else {
                if let url = error.userInfo[kForceUpgradeURL] as? String {
                    errorAlert.addAction(UIAlertAction(title: "Upgrade", style: UIAlertActionStyle.Destructive, handler: { (action) -> Void in
                        let actualURL = NSURL(string: url)
                        if (actualURL != nil) {
                            UIApplication.sharedApplication().openURL(actualURL!)
                        }
                        
                    }))
                }
            }
            errorAlert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
            
            
        }
    }
    

}
