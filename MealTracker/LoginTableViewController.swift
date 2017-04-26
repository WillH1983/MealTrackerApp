//
//  LoginTableViewController.swift
//  MealTracker
//
//  Created by William Hindenburg on 8/4/15.
//
//

import UIKit
import BaseClassesSwift

class LoginTableViewController: MealBaseTableViewController {
    @IBOutlet weak var userName: UITextField?
    @IBOutlet weak var password:UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let user = User.persistentUserObject()
        if user.idToken.isEmpty == false {
            self.performSegue(withIdentifier: "tabbar", sender: self)
        }
    }
    
    @IBAction func registerNowTapped(_ sender:AnyObject) {
        let user = RegisterUser()
        let userNameString = self.userName?.text
        let passwordString = self.password?.text
        super.showActivityIndicator(animated: true)
        if userNameString != nil && passwordString != nil {
            user.username = userNameString!
            user.password = passwordString!
            user.email = userNameString!
            let authService = AuthenticationService()
            authService.registerUser(user, withSuccessBlock: { (userObject) -> Void in
                user.password = ""
                self.saveUser(userObject)
                self.performSegue(withIdentifier: "tabbar", sender: self)
                self.userName?.text = ""
                self.password?.text = ""
                super.hideActivityIndicator(animated: true)
            }, andError: { (error) -> Void in
                super.hideActivityIndicator(animated: true)
                super.showError(error, withRetry: { () -> Void in
                    self.registerNowTapped(sender)
                })
            })
        } else {
            super.hideActivityIndicator(animated: true)
        }
    }
    
    @IBAction func loginTapped(_ sender:AnyObject) {
        let user = RegisterUser()
        let userNameString = self.userName?.text
        let passwordString = self.password?.text
        super.showActivityIndicator(animated: true)
        if userNameString != nil && passwordString != nil {
            user.username = userNameString!
            user.password = passwordString!
            user.email = userNameString!
            let authService = AuthenticationService()
            authService.loginUser(user, withSuccessBlock: { (userObject) -> Void in
                self.saveUser(userObject)
                self.performSegue(withIdentifier: "tabbar", sender: self)
                self.userName?.text = ""
                self.password?.text = ""
                super.hideActivityIndicator(animated: true)
                }, andError: { (error) -> Void in
                    super.hideActivityIndicator(animated: true)
                    super.showError(error, withRetry: { () -> Void in
                        self.loginTapped(sender)
                    })
            })
        } else {
            super.hideActivityIndicator(animated: true)
        }
    }
    
    func saveUser(_ user:User) {
        user.save()
    }

}
