//
//  MealEatenService.swift
//  MealTracker
//
//  Created by William Hindenburg on 1/10/16.
//
//

import Foundation
import BaseClassesSwift

class MealEatenServiceSwift: NSObject, BaseClassesService {
    func saveMealEaten(mealEaten:MealEatenPost, successBlock:(MealEatenPost -> Void), errorBlock:(NSError -> Void)) {
        BaseClassesServiceClient().postObject(mealEaten, andService: self, successBlock: { (object:MealEatenPost) -> Void in
            successBlock(object)
        }) { (error) -> Void in
                errorBlock(error)
        }
    }
    
    var serviceURL:String {
        return "/mealseaten"
    }

}
