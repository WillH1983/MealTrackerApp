//
//  REPlenishBaseTableViewController.swift
//  REPlenish
//
//  Created by William Hindenburg on 9/22/15.
//  Copyright © 2015 Robot Woods, LLC. All rights reserved.
//

import UIKit
import KVNProgress

open class BaseTableViewController: UITableViewController {
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setToolbarHidden(true, animated: animated)
        self.tableView.tableFooterView = UIView()
    }
    
    open func showActivityIndicatorAnimated(_ animated:Bool) {
        KVNProgress.show()
    }
    
    open func hideActivityIndicatorAnimated(_ animated:Bool) {
        KVNProgress.dismiss()
    }
    
    open func createAlertController(_ title:String, message:String, defaultButton:Bool) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        if defaultButton {
            let alertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (action) -> Void in
                
            })
            alertController.addAction(alertAction)
        }
        return alertController
    }
    
    open func displayGenericNetworkError() {
        let alert = self.createAlertController("Error", message: "Something went wrong, please try again", defaultButton: true)
        self.present(alert, animated: true, completion: nil)
    }
    
    open func displayError(_ error:NSError) {
        let alert = self.createAlertController("Error", message: error.localizedDescription, defaultButton: true)
        self.present(alert, animated: true, completion: nil)
    }
    
    open func displayLocationServicesNotEnabledError() {
        let alertController = UIAlertController(
            title: "Location Access Disabled",
            message: "To enable Scrub Tech to use your location please open this app's settings and set location access to 'While Using the App'.",
            preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
            if let url = URL(string:UIApplicationOpenSettingsURLString) {
                UIApplication.shared.openURL(url)
            }
        }
        alertController.addAction(openAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    open func displayLocationServicesNotAvaliableError() {
        let alertController = UIAlertController(
            title: "Location Access Disabled",
            message: "To enable Scrub Tech your location is required. Your location is not available.",
            preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true, completion: nil)
    }
    
    open func displayDeviceLocationServicesNotAvaliableError() {
        let alertController = UIAlertController(
            title: "Location Services Disabled",
            message: "To enable Scrub Tech your location is required. Your location is not available on your device.  Please enable your device location services",
            preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    open func showError(_ error:NSError, retryBlock:@escaping ((Void) -> Void)) {
        if User.persistentUserObject().idToken.isEmpty == false {
            let errorMessage = error.localizedDescription
            var title = ""
            var style = UIAlertControllerStyle.actionSheet
            
            if error.code == SwiftServiceErrorCode.forceUpgrade.rawValue {
                title = error.userInfo[kForceUpgradeTitleKey] as? String ?? "Error"
                style = UIAlertControllerStyle.alert
                
            } else if error.code == SwiftServiceErrorCode.maintenanceMode.rawValue {
                title = error.userInfo[kMaintenanceModeErrorTitleKey] as? String ?? "Error"
            }
            
            let errorAlert = UIAlertController(title: title, message: errorMessage, preferredStyle: style)
            
            if error.code != SwiftServiceErrorCode.forceUpgrade.rawValue {
                errorAlert.addAction(UIAlertAction(title: "Retry", style: UIAlertActionStyle.destructive, handler: { (action) -> Void in
                    retryBlock()
                }))
            } else {
                if let url = error.userInfo[kForceUpgradeURL] as? String {
                    errorAlert.addAction(UIAlertAction(title: "Upgrade", style: UIAlertActionStyle.destructive, handler: { (action) -> Void in
                        let actualURL = URL(string: url)
                        if (actualURL != nil) {
                            UIApplication.shared.openURL(actualURL!)
                        }
                        
                    }))
                }
            }
            errorAlert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
            
            
        }
    }

}
