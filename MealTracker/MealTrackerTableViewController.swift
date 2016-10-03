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
    
    func viewController(sender: UIViewController, didFinishWithMeal: Meal) {
        super.showActivityIndicatorAnimated(true)
        SaveMealServiceSwift().saveMeal(didFinishWithMeal, successBlock: { (meal) -> Void in
            self.tableView.reloadData()
            super.hideActivityIndicatorAnimated(true)
        }) { (error) -> Void in
            super.hideActivityIndicatorAnimated(true)
            super.showError(error, withRetryBlock: { () -> Void in
                self.viewController(sender, didFinishWithMeal: didFinishWithMeal)
            })
        }
    }
    
    func viewController(sender: UIViewController, didFinishEditingMeal: Meal) {
        super.showActivityIndicatorAnimated(true)
        SaveMealServiceSwift().updateMeal(didFinishEditingMeal, successBlock: { () -> Void in
            super.hideActivityIndicatorAnimated(true)
        }) { (error) -> Void in
            super.hideActivityIndicatorAnimated(true)
            super.showError(error, withRetryBlock: { () -> Void in
                self.viewController(sender, didFinishEditingMeal: didFinishEditingMeal)
            })
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let navController = segue.destinationViewController as! UINavigationController
        let mealEntryController = navController.topViewController as! MealEntryTableViewController
        mealEntryController.textEntryDelegate = self
        
        if let cell = sender as? UITableViewCell {
            let indexPath = self.tableView.indexPathForCell(cell)
            if indexPath != nil {
                mealEntryController.mealData = self.dataSource?[indexPath!.row]
            }
            
            
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.retrieveMealsFromService()
    }
    
    func retrieveMealsFromService() {
        super.showActivityIndicatorAnimated(true)
        RetrieveMealService().retrieveMeals({ (meals) -> Void in
            self.dataSource = meals
            self.tableView.reloadData()
            super.hideActivityIndicatorAnimated(true)
        }) { (error) -> Void in
            super.hideActivityIndicatorAnimated(true)
            super.showError(error, withRetryBlock: { () -> Void in
                self.retrieveMealsFromService()
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.user = User.persistentUserObject()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "Meal Cell"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
        }
        let mealCell = cell!
        
        let button = UIButton(frame: CGRectMake(0, 0, 35, 35))
        button.setBackgroundImage(UIImage(named: "plusButton"), forState: UIControlState.Normal)
        button.addTarget(self, action: "disclosureButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        mealCell.accessoryView = button
        
        let meal = self.dataSource?[indexPath.row]
        mealCell.textLabel?.text = meal?.name
        mealCell.detailTextLabel?.text = (meal?.weightWatchersPlusPoints.stringValue)! + " Weight Watchers Points"
        
        return mealCell
        
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            let meal = self.dataSource?[indexPath.row]
            super.showActivityIndicatorAnimated(true)
            DeleteMealServiceSwift().removeMeal(meal!, successBlock: { () -> Void in
                self.dataSource?.removeAtIndex(indexPath.row)
                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
                super.hideActivityIndicatorAnimated(true)
            }, errorBlock: { (error) -> Void in
                super.hideActivityIndicatorAnimated(true)
                super.showError(error, withRetryBlock: { () -> Void in
                    self.tableView(tableView, commitEditingStyle: editingStyle, forRowAtIndexPath: indexPath)
                })
            })
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource?.count ?? 0
    }
    
    func disclosureButtonPressed(sender:UIButton) {
        if let cell = sender.superview as? UITableViewCell {
            let imageView = UIImageView(image: UIImage(named: "plusButton"))
            let p = self.tableView.convertPoint((cell.accessoryView?.frame.origin)!, fromView: cell)
            imageView.frame = CGRectMake(p.x, p.y, 35, 35)
            self.view.addSubview(imageView)
            
            UIView.animateWithDuration(1.0, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                imageView.frame = CGRectMake(self.view.frame.size.width - ((self.view.frame.size.width - cell.accessoryView!.frame.origin.x) + 50.0), (self.tableView.bounds.size.height + self.tableView.contentOffset.y), imageView.frame.size.width, imageView.frame.size.height);
                imageView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.99, 0.99);
            }, completion: { (finished) -> Void in
                imageView.transform = CGAffineTransformIdentity;
                imageView.removeFromSuperview()
            })
            
            if let indexPath = self.tableView.indexPathForCell(cell) {
                let mealEaten = MealEaten()
                mealEaten.meal = (self.dataSource?[indexPath.row])!
                mealEaten.dateEaten = NSDate()
                self.saveMealEaten(mealEaten)
            }            
        }
    }
    
    func saveMealEaten(mealEaten:MealEaten) {
        super.showActivityIndicatorAnimated(true)
        MealEatenServiceSwift().saveMealEaten(mealEaten, successBlock: { (meal) -> Void in
            super.hideActivityIndicatorAnimated(true)
        }) { (error) -> Void in
            super.hideActivityIndicatorAnimated(true)
            super.showError(error, withRetryBlock: { () -> Void in
                self.saveMealEaten(mealEaten)
            })
        }
    }

}
