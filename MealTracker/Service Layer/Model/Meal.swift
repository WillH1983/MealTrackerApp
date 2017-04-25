//
//  Meal.swift
//  MealTracker
//
//  Created by William Hindenburg on 1/9/16.
//
//

import UIKit
import BaseClassesSwift
import ObjectMapper

open class Meal: BaseModel {
    var calories = NSDecimalNumber()
    var carbs = NSDecimalNumber()
    var dietaryFiber = NSDecimalNumber()
    var mealDescription = ""
    var name = ""
    var protein = NSDecimalNumber()
    var servingSize = ""
    var totalFat = NSDecimalNumber()
    var weightWatchersPlusPoints = NSDecimalNumber()
    var whenEaten = NSSet()
    var newObjectId = 0
    
    class func mealForDictionaryInfo(_ mealDictionary:Dictionary<String, AnyObject>) {
        let meal = Meal()
        meal.name = mealDictionary.name
        meal.carbs = mealDictionary.carbs
        meal.dietaryFiber = mealDictionary.dietaryFiber
        meal.mealDescription = mealDictionary.description
        meal.protein = mealDictionary.protein
        meal.servingSize = mealDictionary.serving
        meal.totalFat = mealDictionary.totalFat
        meal.weightWatchersPlusPoints = mealDictionary.points
    }
    
    override init() {
        super.init()
    }
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    override open func mapping(_ map: Map) {
        super.mapping(map)
        calories <- (map["Calories"], BaseClassesDecimalNumberTransform())
        carbs <- (map["Carbs"], BaseClassesDecimalNumberTransform())
        dietaryFiber <- (map["DietaryFiber"], BaseClassesDecimalNumberTransform())
        mealDescription <- map["MealDescription"]
        name <- map["Name"]
        protein <- (map["Protein"], BaseClassesDecimalNumberTransform())
        servingSize <- map["ServingSize"]
        totalFat <- (map["TotalFat"], BaseClassesDecimalNumberTransform())
        weightWatchersPlusPoints <- (map["WeightWatchersPlusPoints"], BaseClassesDecimalNumberTransform())
        newObjectId <- map["ObjectId"]
        whenEaten <- map["whenEaten"]
    }
}

extension Dictionary {
    var name:String {
        get {
            if let nameValue = self["name" as! Key] as? String {
                return nameValue
            } else {
                return ""
            }
        }
        set {
            self["name" as! Key] = (newValue as! Value)
        }
    }
    
    var description:String {
        get {
            if let descriptionValue = self["description" as! Key] as? String {
                return descriptionValue
            } else {
                return ""
            }
        }
        set {
            self["description" as! Key] = (newValue as! Value)
        }
    }
    
    var carbs:NSDecimalNumber {
        get {
            if let carbsValue = self["carbs" as! Key] as? NSDecimalNumber {
                return carbsValue
            } else {
                return NSDecimalNumber()
            }
        }
        set {
            self["carbs" as! Key] = (newValue as! Value)
        }
    }
    
    var dietaryFiber:NSDecimalNumber {
        get {
            if let dietaryFiberValue = self["dietaryFiber" as! Key] as? NSDecimalNumber {
                return dietaryFiberValue
            } else {
                return NSDecimalNumber()
            }
        }
        set {
            self["dietaryFiber" as! Key] = (newValue as! Value)
        }
    }
    
    var protein:NSDecimalNumber {
        get {
            if let proteinValue = self["protein" as! Key] as? NSDecimalNumber {
                return proteinValue
            } else {
                return NSDecimalNumber()
            }
        }
        set {
            self["protein" as! Key] = (newValue as! Value)
        }
    }
    
    var serving:String {
        get {
            if let servingValue = self["serving" as! Key] as? String {
                return servingValue
            } else {
                return ""
            }
        }
        set {
            self["serving" as! Key] = (newValue as! Value)
        }
    }
    
    var totalFat:NSDecimalNumber {
        get {
            if let totalFatValue = self["totalFat" as! Key] as? NSDecimalNumber {
                return totalFatValue
            } else {
                return NSDecimalNumber()
            }
        }
        set {
            self["totalFat" as! Key] = (newValue as! Value)
        }
    }
    
    var points:NSDecimalNumber {
        get {
            if let pointsValue = self["points" as! Key] as? NSDecimalNumber {
                return pointsValue
            } else {
                return NSDecimalNumber()
            }
        }
        set {
            self["points" as! Key] = (newValue as! Value)
        }
    }
}
