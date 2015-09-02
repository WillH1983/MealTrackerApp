//
//  MealEntryTableViewController.swift
//  MealTracker
//
//  Created by William Hindenburg on 8/22/15.
//
//

/*

*/

import UIKit

@objc public protocol MealTextEntryDelegate {
    func viewController(sender:UIViewController, didFinishWithMeal:Meal)
    func viewController(sender:UIViewController, didFinishEditingMeal:Meal)
}

@objc public class MealEntryTableViewController: UITableViewController, UITextFieldDelegate {
    @IBOutlet weak var mealNameText: UITextField?
    @IBOutlet weak var carbsText: UITextField?
    @IBOutlet weak var dietaryFiberText: UITextField?
    @IBOutlet weak var totalProteinText: UITextField?
    @IBOutlet weak var servingSizeText: UITextField?
    @IBOutlet weak var totalFatText: UITextField?
    @IBOutlet weak var WWPointsText: UITextField?
    @IBOutlet weak var mealDescriptionText: UITextField?
    
    var activeField: UITextField?
    public var textEntryDelegate: MealTextEntryDelegate?
    public var mealData: Meal?
    
    @IBAction func saveButtonPressed(sender:UIBarButtonItem) {
        if let mealName = self.mealNameText?.text {
                let meal = Meal()
                meal.name = mealName
                meal.mealDescription = self.mealDescriptionText?.text ?? ""
                meal.carbs = NSDecimalNumber(string: self.carbsText?.text)
                meal.weightWatchersPlusPoints = NSDecimalNumber(string: self.WWPointsText?.text)
            
                self.mealData = meal
                if (meal.objectId != nil) {
                    self.textEntryDelegate?.viewController(self, didFinishEditingMeal: self.mealData!)
                } else {
                    self.textEntryDelegate?.viewController(self, didFinishWithMeal: self.mealData!)
                }
                self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
            
        } else {
            let alert = UIAlertView(title: "Meal Tracker", message: "Please Enter a Meal Name", delegate: nil, cancelButtonTitle: "Okay")
            alert.show()
        }
    }
    
    @IBAction func cancelButtonPressed(sender:UIBarButtonItem) {
        if let viewControllerPresenting = self.presentingViewController {
            viewControllerPresenting.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func weightWatchersPointsForProtein(p: NSDecimalNumber, carbohydrates: NSDecimalNumber, totalFat: NSDecimalNumber, andDietaryFiber:NSDecimalNumber) -> NSDecimalNumber {
        let pp = max(round((p.doubleValue * 16 + carbohydrates.doubleValue * 19 + totalFat.doubleValue * 45)/175) - andDietaryFiber.doubleValue * (2/25), 0)
        return NSDecimalNumber(double: pp)
    
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        self.mealNameText?.delegate = self
        self.carbsText?.delegate = self
        self.dietaryFiberText?.delegate = self
        self.totalProteinText?.delegate = self
        self.servingSizeText?.delegate = self
        self.totalFatText?.delegate = self
        self.WWPointsText?.delegate = self
        self.mealDescriptionText?.delegate = self
        
        self.mealNameText?.text = ""
        self.carbsText?.text = ""
        self.dietaryFiberText?.text = ""
        self.totalProteinText?.text = ""
        self.servingSizeText?.text = ""
        self.totalFatText?.text = ""
        self.WWPointsText?.text = ""
        self.mealDescriptionText?.text = ""
        
        if let meal = self.mealData {
            self.mealNameText?.text = meal.name
            self.mealDescriptionText?.text = meal.mealDescription
            self.servingSizeText?.text = meal.servingSize
            
            if meal.carbs != NSDecimalNumber.notANumber() {
                self.carbsText?.text = meal.carbs.stringValue
            }
            
            if meal.dietaryFiber != NSDecimalNumber.notANumber() {
                self.dietaryFiberText?.text = meal.dietaryFiber.stringValue
            }
            
            if meal.protein != NSDecimalNumber.notANumber() {
                self.totalProteinText?.text = meal.protein.stringValue
            }
            
            if meal.totalFat != NSDecimalNumber.notANumber() {
                self.totalFatText?.text = meal.totalFat.stringValue
            }
            
            if meal.weightWatchersPlusPoints != NSDecimalNumber.notANumber() {
                self.WWPointsText?.text = meal.weightWatchersPlusPoints.stringValue
            }
        }
    }
    
    func dismissKeyboard() {
        self.mealNameText?.resignFirstResponder()
        self.carbsText?.resignFirstResponder()
        self.dietaryFiberText?.resignFirstResponder()
        self.totalProteinText?.resignFirstResponder()
        self.servingSizeText?.resignFirstResponder()
        self.totalFatText?.resignFirstResponder()
        self.WWPointsText?.resignFirstResponder()
        self.mealDescriptionText?.resignFirstResponder()
    }
    
    public func textFieldDidBeginEditing(textField: UITextField) {
        self.activeField = textField
    }
    
    public func textFieldDidEndEditing(textField: UITextField) {
        self.activeField = nil
        if self.totalProteinText?.text?.isEmpty == false &&
        self.carbsText?.text?.isEmpty == false &&
        self.totalFatText?.text?.isEmpty == false &&
        self.dietaryFiberText?.text?.isEmpty == false {
            let wwPoints = self.weightWatchersPointsForProtein(NSDecimalNumber(string: self.totalProteinText?.text), carbohydrates: NSDecimalNumber(string: self.carbsText?.text), totalFat: NSDecimalNumber(string: self.totalFatText?.text), andDietaryFiber:NSDecimalNumber(string:self.dietaryFiberText?.text))
            self.WWPointsText?.text = wwPoints.stringValue
        }
    }

}
