//
//  REPlenishBaseViewController.swift
//  REPlenish
//
//  Created by William Hindenburg on 9/27/15.
//  Copyright © 2015 Robot Woods, LLC. All rights reserved.
//

import UIKit
import KVNProgress

class BaseViewController: UIViewController {
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setToolbarHidden(true, animated: animated)
    }
    
    func showActivityIndicatorAnimated(animated:Bool) {
        if KVNProgress.isVisible() == false {
            KVNProgress.show()
        }
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

}
