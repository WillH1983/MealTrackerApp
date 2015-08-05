//
//  LoginTableViewController.swift
//  MealTracker
//
//  Created by William Hindenburg on 8/4/15.
//
//

import UIKit
import BaseClasses

class LoginTableViewController: MealBaseTableViewController {
    @IBOutlet weak var userName: UITextField?
    @IBOutlet weak var password:UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let user = User.persistentUserObject()
        if user.sessionToken.isEmpty == false {
            self.performSegueWithIdentifier("tabbar", sender: self)
        }
    }
    
    @IBAction func registerNowTapped(sender:AnyObject) {
        let user = User()
        let userNameString = self.userName?.text
        let passwordString = self.password?.text
        super.showActivityIndicatorAnimated(true)
        if userNameString != nil && passwordString != nil {
            user.username = userNameString!
            user.password = passwordString!
            let authService = AuthenticationService()
            authService.registerUser(user, withSuccessBlock: { (userObject) -> Void in
                user.password = ""
                self.saveUser(userObject)
                self.performSegueWithIdentifier("tabbar", sender: self)
                self.userName?.text = ""
                self.password?.text = ""
                super.hideActivityIndicatorAnimated(true)
            }, andError: { (error) -> Void in
                super.hideActivityIndicatorAnimated(true)
                super.showError(error, withRetryBlock: { () -> Void in
                    self.registerNowTapped(sender)
                })
            })
        } else {
            super.hideActivityIndicatorAnimated(true)
        }
    }
    
    @IBAction func loginTapped(sender:AnyObject) {
        let user = User()
        let userNameString = self.userName?.text
        let passwordString = self.password?.text
        super.showActivityIndicatorAnimated(true)
        if userNameString != nil && passwordString != nil {
            user.username = userNameString!
            user.password = passwordString!
            let authService = AuthenticationService()
            authService.loginUser(user, withSuccessBlock: { (userObject) -> Void in
                self.saveUser(userObject)
                self.performSegueWithIdentifier("tabbar", sender: self)
                self.userName?.text = ""
                self.password?.text = ""
                super.hideActivityIndicatorAnimated(true)
                }, andError: { (error) -> Void in
                    super.hideActivityIndicatorAnimated(true)
                    super.showError(error, withRetryBlock: { () -> Void in
                        self.loginTapped(sender)
                    })
            })
        } else {
            super.hideActivityIndicatorAnimated(true)
        }
    }
    
    func saveUser(user:User) {
        user.save()
    }

}
