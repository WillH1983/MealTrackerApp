//
//  TrackerTableViewController.swift
//  MealTracker
//
//  Created by William Hindenburg on 9/1/15.
//
//

import UIKit
import BaseClassesSwift

class TrackerTableViewController2: MealBaseTableViewController {

    var user = User.persistentUserObject()
    var dataSource:Array <Dictionary<String, AnyObject>> = [[String: AnyObject]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.retrieveMealHistory()
    }
    
    func retrieveMealHistory() {
        super.showActivityIndicatorAnimated(true)
//        RetrieveMealHistoryService().loadMealHistoryBasedOnUser(self.user, withSuccessBlock: { (dataSource) -> Void in
//            self.dataSource = dataSource
//            self.tableView.reloadData()
//            super.hideActivityIndicatorAnimated(true)
//        }) { (error) -> Void in
//            super.hideActivityIndicatorAnimated(true)
//            super.showError(error, withRetryBlock: { () -> Void in
//                self.retrieveMealHistory()
//            })
//        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "Date Eaten Cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
        }
        
        if let mealEaten = self.mealEatenForIndexPath(indexPath) {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
            dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
            
            let formattedDateString = dateFormatter.stringFromDate(mealEaten.dateEaten)
            let fullString = formattedDateString + " - " + mealEaten.meal.weightWatchersPlusPoints.stringValue + " Points"
            cell?.detailTextLabel?.text = fullString
            cell?.textLabel?.text = mealEaten.meal.name
        }
        return cell!

    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45.0
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.dataSource.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let dataSourceForSection = self.dataSource[section]
        if let array = dataSourceForSection["meals"] as? Array<MealEaten> {
            return array.count
        } else {
            return 1
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let dataSourceForSection = self.dataSource[section]
        if let date = dataSourceForSection["month"] as? NSDate {
            if let array = dataSourceForSection["meals"] as? Array<MealEaten> {
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
                dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
                
                var points = 0
                for dateEaten in array {
                    points += dateEaten.meal.weightWatchersPlusPoints.integerValue
                }
                let pointsLeft = self.user.pointsPerWeek.integerValue - points
                let sectionTitle = dateFormatter.stringFromDate(date)
                let fullSectionTitle = sectionTitle + " - " + String(pointsLeft) + " Points Left"
                return fullSectionTitle
            }
        }
        return ""
    }
    
    func dataSourceArrayForSection(section:Int) -> Array<Dictionary<String, AnyObject>> {
        let dataSourceForSection = self.dataSource[section]
        if let array = dataSourceForSection["meals"] as? Array<Dictionary<String,AnyObject>> {
            return array
        } else {
            return [[String: AnyObject]]()
        }
    }
    
    func mealEatenForIndexPath(indexPath:NSIndexPath) -> MealEaten? {
        let dataSourceForSection = self.dataSource[indexPath.section]
        if let array = dataSourceForSection["meals"] as? Array<AnyObject> {
            if let mealEaten = array[indexPath.row] as? MealEaten {
                return mealEaten
            } else {
                return nil
            }
        } else {
            return nil
        }
    }

}
