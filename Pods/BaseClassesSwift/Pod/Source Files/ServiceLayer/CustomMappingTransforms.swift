//
//  CustomMappingTransforms.swift
//  Pods
//
//  Created by William Hindenburg on 1/9/16.
//
//

import Foundation
import ObjectMapper

open class BaseClassesDateTransform: TransformType {
    public typealias Object = Date
    public typealias JSON = String
    
    public init() {}
    
    open func transformFromJSON(_ value: Any?) -> Date? {
        if let timeInt = value as? Double {
            return Date(timeIntervalSince1970: TimeInterval(timeInt))
        }
        
        if let timeStr = value as? String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
            dateFormatter.timeZone = TimeZone(identifier: "UTC")
            let date = dateFormatter.date(from: timeStr)
            return date
        }
        
        return nil
    }
    
    open func transformToJSON(_ value: Date?) -> String? {
        if let date = value {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
            dateFormatter.timeZone = TimeZone(identifier: "UTC")
            let dateString = dateFormatter.string(from: date)
            return dateString
        }
        return nil
    }
}

open class BaseClassesDecimalNumberTransform: TransformType {
    public typealias Object = NSDecimalNumber
    public typealias JSON = String
    
    public init() {}
    
    open func transformFromJSON(_ value: Any?) -> NSDecimalNumber? {
        if let stringValue = value as? String {
            let number = NSDecimalNumber(string: stringValue)
            return number
        }
        return nil
    }
    
    open func transformToJSON(_ value: NSDecimalNumber?) -> String? {
        if let numberValue = value {
            let formatter = NumberFormatter()
            let stringValue = formatter.string(from: numberValue)
            return stringValue
        }
        return nil
    }
}
