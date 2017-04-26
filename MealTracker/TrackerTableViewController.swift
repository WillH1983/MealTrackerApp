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
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.user = User.persistentUserObject();
        self.retrieveMealHistory()
    }
    
    func retrieveMealHistory() {
        super.showActivityIndicator(animated: true)
        RetrieveMealHistoryService().loadMealHistoryBased(on: self.user, withSuccessBlock: { (dataSource) -> Void in
            self.dataSource = dataSource as Array<Dictionary<String, AnyObject>>
            self.tableView.reloadData()
            super.hideActivityIndicator(animated: true)
        }) { (error) -> Void in
            super.hideActivityIndicator(animated: true)
            super.showError(error, withRetry: { () -> Void in
                self.retrieveMealHistory()
            })
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Date Eaten Cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: cellIdentifier)
        }
        
        if let mealEaten = self.mealEatenForIndexPath(indexPath) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = DateFormatter.Style.medium
            dateFormatter.timeStyle = DateFormatter.Style.short
            
            let formattedDateString = dateFormatter.string(from: mealEaten.dateEaten as Date)
            let fullString = formattedDateString + " - " + mealEaten.meal.weightWatchersPlusPoints.stringValue + " Points"
            cell?.detailTextLabel?.text = fullString
            cell?.textLabel?.text = mealEaten.meal.name
        }
        return cell!

    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45.0
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let dataSourceForSection = self.dataSource[section]
        if let array = dataSourceForSection["meals"] as? Array<MealEaten> {
            return array.count
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let dataSourceForSection = self.dataSource[section]
        if let date = dataSourceForSection["month"] as? Date {
            if let array = dataSourceForSection["meals"] as? Array<MealEaten> {
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = DateFormatter.Style.medium
                dateFormatter.timeStyle = DateFormatter.Style.none
                
                var points = 0
                for dateEaten in array {
                    points += dateEaten.meal.weightWatchersPlusPoints.intValue
                }
                let pointsLeft = self.user.pointsPerWeek.intValue - points
                let sectionTitle = dateFormatter.string(from: date)
                let fullSectionTitle = sectionTitle + " - " + String(pointsLeft) + " Points Left"
                return fullSectionTitle
            }
        }
        return ""
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            super.showActivityIndicator(animated: true)
            let meal = self.mealEatenForIndexPath(indexPath)
            DeleteMealEatenServiceSwift().removeMealEaten(meal!, successBlock: { () -> Void in
                var mutableCapsuleArray = self.dataSourceArrayForSection(indexPath.section)
                mutableCapsuleArray.remove(at: indexPath.row)
                self.tableView.reloadSections(IndexSet(integer: indexPath.section), with: UITableViewRowAnimation.automatic)
                super.hideActivityIndicator(animated: true)
            }, errorBlock: { (error) -> Void in
                super.hideActivityIndicator(animated: true)
                super.showError(error, withRetry: { () -> Void in
                    self.tableView(tableView, commit:editingStyle , forRowAt: indexPath)
                })
            })
        }
    }
    
    func dataSourceArrayForSection(_ section:Int) -> Array<Dictionary<String, AnyObject>> {
        let dataSourceForSection = self.dataSource[section]
        if let array = dataSourceForSection["meals"] as? Array<Dictionary<String,AnyObject>> {
            return array
        } else {
            return [[String: AnyObject]]()
        }
    }
    
    func mealEatenForIndexPath(_ indexPath:IndexPath) -> MealEaten? {
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
