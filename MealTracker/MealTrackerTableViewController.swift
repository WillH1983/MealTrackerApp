//
//  MealTrackerTableViewController.swift
//  MealTracker
//
//  Created by William Hindenburg on 8/29/15.
//
//

import UIKit
import BaseClassesSwift

class MealTrackerTableViewController: MealBaseTableViewController, MealTextEntryDelegate {
    var dataSource:Array <Meal>?
    var user:User?
    
    func viewController(_ sender: UIViewController, didFinishWithMeal: Meal) {
        super.showActivityIndicator(animated: true)
        SaveMealServiceSwift().saveMeal(didFinishWithMeal, successBlock: { (meal) -> Void in
            self.tableView.reloadData()
            super.hideActivityIndicator(animated: true)
        }) { (error) -> Void in
            super.hideActivityIndicator(animated: true)
            super.showError(error, withRetry: { () -> Void in
                self.viewController(sender, didFinishWithMeal: didFinishWithMeal)
            })
        }
    }
    
    func viewController(_ sender: UIViewController, didFinishEditingMeal: Meal) {
        super.showActivityIndicator(animated: true)
        SaveMealServiceSwift().updateMeal(didFinishEditingMeal, successBlock: { () -> Void in
            super.hideActivityIndicator(animated: true)
        }) { (error) -> Void in
            super.hideActivityIndicator(animated: true)
            super.showError(error, withRetry: { () -> Void in
                self.viewController(sender, didFinishEditingMeal: didFinishEditingMeal)
            })
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navController = segue.destination as! UINavigationController
        let mealEntryController = navController.topViewController as! MealEntryTableViewController
        mealEntryController.textEntryDelegate = self
        
        if let cell = sender as? UITableViewCell {
            let indexPath = self.tableView.indexPath(for: cell)
            if indexPath != nil {
                mealEntryController.mealData = self.dataSource?[indexPath!.row]
            }
            
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.retrieveMealsFromService()
    }
    
    func retrieveMealsFromService() {
        super.showActivityIndicator(animated: true)
        RetrieveMealService().retrieveMeals({ (meals) -> Void in
            self.dataSource = meals
            self.tableView.reloadData()
            super.hideActivityIndicator(animated: true)
        }) { (error) -> Void in
            super.hideActivityIndicator(animated: true)
            super.showError(error, withRetry: { () -> Void in
                self.retrieveMealsFromService()
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.user = User.persistentUserObject()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Meal Cell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: cellIdentifier)
        }
        let mealCell = cell!
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        button.setBackgroundImage(UIImage(named: "plusButton"), for: UIControlState())
        button.addTarget(self, action: #selector(MealTrackerTableViewController.disclosureButtonPressed(_:)), for: UIControlEvents.touchUpInside)
        mealCell.accessoryView = button
        
        let meal = self.dataSource?[indexPath.row]
        mealCell.textLabel?.text = meal?.name
        mealCell.detailTextLabel?.text = (meal?.weightWatchersPlusPoints.stringValue)! + " Weight Watchers Points"
        
        return mealCell
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            let meal = self.dataSource?[indexPath.row]
            super.showActivityIndicator(animated: true)
            DeleteMealServiceSwift().removeMeal(meal!, successBlock: { () -> Void in
                self.dataSource?.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
                super.hideActivityIndicator(animated: true)
            }, errorBlock: { (error) -> Void in
                super.hideActivityIndicator(animated: true)
                super.showError(error, withRetry: { () -> Void in
                    self.tableView(tableView, commit: editingStyle, forRowAt: indexPath)
                })
            })
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource?.count ?? 0
    }
    
    func disclosureButtonPressed(_ sender:UIButton) {
        if let cell = sender.superview as? UITableViewCell {
            let imageView = UIImageView(image: UIImage(named: "plusButton"))
            let p = self.tableView.convert((cell.accessoryView?.frame.origin)!, from: cell)
            imageView.frame = CGRect(x: p.x, y: p.y, width: 35, height: 35)
            self.view.addSubview(imageView)
            
            UIView.animate(withDuration: 1.0, delay: 0, options: UIViewAnimationOptions(), animations: { () -> Void in
                imageView.frame = CGRect(x: self.view.frame.size.width - ((self.view.frame.size.width - cell.accessoryView!.frame.origin.x) + 50.0), y: (self.tableView.bounds.size.height + self.tableView.contentOffset.y), width: imageView.frame.size.width, height: imageView.frame.size.height);
                imageView.transform = CGAffineTransform.identity.scaledBy(x: 0.99, y: 0.99);
            }, completion: { (finished) -> Void in
                imageView.transform = CGAffineTransform.identity;
                imageView.removeFromSuperview()
            })
            
            if let indexPath = self.tableView.indexPath(for: cell) {
                let mealEaten = MealEatenPost()
                mealEaten.meal = (self.dataSource?[indexPath.row])!
                mealEaten.dateEaten = Date()
                self.saveMealEaten(mealEaten)
            }            
        }
    }
    
    func saveMealEaten(_ mealEaten:MealEatenPost) {
        super.showActivityIndicator(animated: true)
        MealEatenServiceSwift().saveMealEaten(mealEaten, successBlock: { (meal) -> Void in
            super.hideActivityIndicator(animated: true)
        }) { (error) -> Void in
            super.hideActivityIndicator(animated: true)
            super.showError(error, withRetry: { () -> Void in
                self.saveMealEaten(mealEaten)
            })
        }
    }

}
