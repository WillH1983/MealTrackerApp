//
//  REPlenishBaseViewController.swift
//  REPlenish
//
//  Created by William Hindenburg on 9/27/15.
//  Copyright © 2015 Robot Woods, LLC. All rights reserved.
//

import UIKit
import KVNProgress

open class BaseViewController: UIViewController {
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setToolbarHidden(true, animated: animated)
    }
    
    open func showActivityIndicatorAnimated(_ animated:Bool) {
        if KVNProgress.isVisible() == false {
            KVNProgress.show()
        }
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

}
