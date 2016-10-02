//
//  REPlenishBaseTableViewController.swift
//  REPlenish
//
//  Created by William Hindenburg on 9/22/15.
//  Copyright © 2015 Robot Woods, LLC. All rights reserved.
//

import UIKit
import KVNProgress

public class BaseTableViewController: UITableViewController {
    
    override public func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setToolbarHidden(true, animated: animated)
        self.tableView.tableFooterView = UIView()
    }
    
    public func showActivityIndicatorAnimated(animated:Bool) {
        KVNProgress.show()
    }
    
    public func hideActivityIndicatorAnimated(animated:Bool) {
        KVNProgress.dismiss()
    }
    
    public func createAlertController(title:String, message:String, defaultButton:Bool) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        if defaultButton {
            let alertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
                
            })
            alertController.addAction(alertAction)
        }
        return alertController
    }
    
    public func displayGenericNetworkError() {
        let alert = self.createAlertController("Error", message: "Something went wrong, please try again", defaultButton: true)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    public func displayError(error:NSError) {
        let alert = self.createAlertController("Error", message: error.localizedDescription, defaultButton: true)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    public func displayLocationServicesNotEnabledError() {
        let alertController = UIAlertController(
            title: "Location Access Disabled",
            message: "To enable Scrub Tech to use your location please open this app's settings and set location access to 'While Using the App'.",
            preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let openAction = UIAlertAction(title: "Open Settings", style: .Default) { (action) in
            if let url = NSURL(string:UIApplicationOpenSettingsURLString) {
                UIApplication.sharedApplication().openURL(url)
            }
        }
        alertController.addAction(openAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    public func displayLocationServicesNotAvaliableError() {
        let alertController = UIAlertController(
            title: "Location Access Disabled",
            message: "To enable Scrub Tech your location is required. Your location is not available.",
            preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(cancelAction)

        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    public func displayDeviceLocationServicesNotAvaliableError() {
        let alertController = UIAlertController(
            title: "Location Services Disabled",
            message: "To enable Scrub Tech your location is required. Your location is not available on your device.  Please enable your device location services",
            preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    public func showError(error:NSError, retryBlock:(Void -> Void)) {
        if User.persistentUserObject().idToken.isEmpty == false {
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
                    retryBlock()
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
