//
//  DateUtil.swift
//  SGDrivers
//
//  Created by Nhan Nguyen on 9/4/15.
//  Copyright (c) 2015 Nhan Nguyen. All rights reserved.
//

import UIKit

class DateUtil: NSObject {
   
    class func dateStringFromDate(date: NSDate, format: String) -> String {
        let dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.stringFromDate(date)
    }
    
    class func milisecondFromDate(date: NSDate) -> Double {
        return date.timeIntervalSince1970 * 1000.0
    }
    
    class func dateFromMilisecond(milisecond: Double) -> NSDate {
        return NSDate(timeIntervalSince1970: milisecond / 1000.0)
    }
    
    class func dateStringFromMilisecond(milisecond: Double, format: String) -> String {
        let date: NSDate = dateFromMilisecond(milisecond)
        return dateStringFromDate(date, format: format)
    }
    
    class func dateFromString(string: String, format: String) -> NSDate {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.dateFromString(string)!
    }
}
