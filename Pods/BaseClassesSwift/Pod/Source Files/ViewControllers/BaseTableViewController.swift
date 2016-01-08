//
//  REPlenishBaseTableViewController.swift
//  REPlenish
//
//  Created by William Hindenburg on 9/22/15.
//  Copyright © 2015 Robot Woods, LLC. All rights reserved.
//

import UIKit
import KVNProgress

class BaseTableViewController: UITableViewController {
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setToolbarHidden(true, animated: animated)
        self.tableView.tableFooterView = UIView()
    }
    
    func showActivityIndicatorAnimated(animated:Bool) {
        KVNProgress.show()
    }
    
    func hideActivityIndicatorAnimated(animated:Bool) {
        KVNProgress.dismiss()
    }
    
    func createAlertController(title:String, message:String, defaultButton:Bool) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        if defaultButton {
            let alertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
                
            })
            alertController.addAction(alertAction)
        }
        return alertController
    }
    
    func displayGenericNetworkError() {
        let alert = self.createAlertController("Error", message: "Something went wrong, please try again", defaultButton: true)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func displayError(error:NSError) {
        let alert = self.createAlertController("Error", message: error.localizedDescription, defaultButton: true)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func displayLocationServicesNotEnabledError() {
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
    
    func displayLocationServicesNotAvaliableError() {
        let alertController = UIAlertController(
            title: "Location Access Disabled",
            message: "To enable Scrub Tech your location is required. Your location is not available.",
            preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(cancelAction)

        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func displayDeviceLocationServicesNotAvaliableError() {
        let alertController = UIAlertController(
            title: "Location Services Disabled",
            message: "To enable Scrub Tech your location is required. Your location is not available on your device.  Please enable your device location services",
            preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }

}
