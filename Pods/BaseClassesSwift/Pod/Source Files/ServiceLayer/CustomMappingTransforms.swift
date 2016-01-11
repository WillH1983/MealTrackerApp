//
//  CustomMappingTransforms.swift
//  Pods
//
//  Created by William Hindenburg on 1/9/16.
//
//

import Foundation
import ObjectMapper

public class BaseClassesDateTransform: TransformType {
    public typealias Object = NSDate
    public typealias JSON = String
    
    public init() {}
    
    public func transformFromJSON(value: AnyObject?) -> NSDate? {
        if let timeInt = value as? Double {
            return NSDate(timeIntervalSince1970: NSTimeInterval(timeInt))
        }
        
        if let timeStr = value as? String {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
            dateFormatter.timeZone = NSTimeZone(name: "UTC")
            let date = dateFormatter.dateFromString(timeStr)
            return date
        }
        
        return nil
    }
    
    public func transformToJSON(value: NSDate?) -> String? {
        if let date = value {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
            dateFormatter.timeZone = NSTimeZone(name: "UTC")
            let dateString = dateFormatter.stringFromDate(date)
            return dateString
        }
        return nil
    }
}

public class BaseClassesDecimalNumberTransform: TransformType {
    public typealias Object = NSDecimalNumber
    public typealias JSON = String
    
    public init() {}
    
    public func transformFromJSON(value: AnyObject?) -> NSDecimalNumber? {
        if let stringValue = value as? String {
            let number = NSDecimalNumber(string: stringValue)
            return number
        }
        return nil
    }
    
    public func transformToJSON(value: NSDecimalNumber?) -> String? {
        if let numberValue = value {
            let formatter = NSNumberFormatter()
            let stringValue = formatter.stringFromNumber(numberValue)
            return stringValue
        }
        return nil
    }
}