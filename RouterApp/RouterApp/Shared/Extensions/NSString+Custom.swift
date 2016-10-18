//
//  NSString+Custom.swift
//  ShopOnline
//
//  Created by CanhTran on 8/11/15.
//  Copyright (c) 2015 CanhTran. All rights reserved.
//

import Foundation

extension String {
    
    /**
    Get class Name
    */
    static func className(aClass: AnyClass) -> String
    {
        return NSStringFromClass(aClass).componentsSeparatedByString(".").last!
    }
    
    /**
    Check the string is the email
    
    :returns: ?true:flase
    */
    func isEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluateWithObject(self)
    }
    
    var isValidPassword: Bool {
        if characters.count < 5 { return false }
        if self == "" { return false }
        if rangeOfCharacterFromSet(.letterCharacterSet(), options: .LiteralSearch, range: nil) == nil { return false }
        if rangeOfCharacterFromSet(.decimalDigitCharacterSet(), options: .LiteralSearch, range: nil) == nil { return false }
        let allowedCharacters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789[]/@!~#$%^&*()-_=+{}|\\,.?:;"
        let set = NSCharacterSet(charactersInString: allowedCharacters);
        let inverted = set.invertedSet;
        let filtered = componentsSeparatedByCharactersInSet(inverted).joinWithSeparator("");
        return filtered == self
//        return true
    }

    /// Get localized string
    var localized: String {
        let localizedString = NSLocalizedString(self, comment: "")
        if self == localizedString {
            print("CANNOT FIND TRANSLATION FOR STRING \(self)")
        }
        return localizedString
    }
    
    
    /**
    Check the tring is the phone number
    
    :returns: ?true:false
    */
    func validatePhoneNumber() -> Bool {
        
        if self.characters.count > 15 { return false }
        
        let charcter  = NSCharacterSet(charactersInString: "0123456789").invertedSet
        var filtered:NSString!
        let inputString:NSArray = self.componentsSeparatedByCharactersInSet(charcter)
        filtered = inputString.componentsJoinedByString("")
        return  self == filtered
    }
    
    /**
    Function convert string to money
    
    :returns: money VND
    */
    func convertNumberToMoneyVND() -> String!
    {
        let numberConvert = Int(self)
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale(localeIdentifier: "es_VN")
        return formatter.stringFromNumber(numberConvert!)
    }
    
    func convertMoneyToInt() -> Int
    {
        var string = self
        string = string.stringByReplacingOccurrencesOfString(".", withString: "")
        string = string.stringByReplacingOccurrencesOfString(" ", withString: "")
        string = string.stringByReplacingOccurrencesOfString("₫", withString: "")
        if string.characters.count > 0
        {
            let formatter = NSNumberFormatter()
            formatter.locale = NSLocale(localeIdentifier: "es_VN")
            let double = formatter.numberFromString(string)
            return Int(double!)
        }
        return 0
    }
    
    func getStringComponentsSeparated(byCharactor: String, atIndex: Int) -> String
    {
        let arr = self.componentsSeparatedByString(byCharactor)
        return arr[atIndex]
    }
    
    func getFirstActivity() -> String
    {
        let listActivity = self.componentsSeparatedByString(",")
        if listActivity.count > 1
        {
            return listActivity.first!
        }
        return self
    }
    
    
    /**
     Convert date time from "dd/mm/yyyy" -> "yyyy-mm-dd" to send request to WS
     
     - returns: datetime with format "yyyy-mm-dd"
     */
    func convertToAPIDateTime() -> String {
        var splitStringArray = self.componentsSeparatedByString("/")
        if splitStringArray.count == 3 {
            return String(format:"%@-%@-%@", splitStringArray[2],splitStringArray[1],splitStringArray[0])
        }
        return ""
    }
    
    func convertFromAPIDateTime() -> String {
        var splitStringArray = self.componentsSeparatedByString("-")
        if (splitStringArray.count == 3) {
            return String(format:"%@/%@/%@", splitStringArray[2],splitStringArray[1],splitStringArray[0])
        }
        return ""
    }
   
    
    func convertToCurrentLanguage() -> String {
        return NSLocalizedString(self, comment: "")
    }
    

    func toDateTime() -> NSDate
    {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let startDate = dateFormatter.dateFromString(self) else {
            exit(-1)
        }
        print(startDate)        // 2015-09-15 04:35:53 +0000
//        dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC")
//        guard let startDateUTC = dateFormatter.dateFromString(self) else {
//            exit(-1)
//        }
//        print(startDateUTC)     // 2015-09-15 06:35:53 +0000
        return startDate
    }
    
}