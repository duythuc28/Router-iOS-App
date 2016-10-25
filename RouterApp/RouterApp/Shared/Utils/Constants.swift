//
//  Constants.swift
//  SGDrivers
//
//  Created by Nhan Nguyen on 9/4/15.
//  Copyright (c) 2015 Nhan Nguyen. All rights reserved.
//

import UIKit

class Constants: NSObject {
  
  struct GlobalConstants {
    
    /*********************************************************/
    
    /*********************************************************/
  }
  
  struct ExperfiProducts {
    //        private static let Prefix = "com.experfi.products."
    //        static let NoAds = Prefix + "noads"
    static let NoAds = "com.experfi.removeads"
  }
  
  struct SegueIdentifer {
    static let showCPXDetailSegueIdentifier       = "showCPXDetailSegueIdentifier"
    static let showListLocationsSegueIdentifier   = "showListLocationsSegueIdentifier"
    static let showListClientsSegueIdentifier     = "showListClientsSegueIdentifier"
    static let showAdvanceSegueIdentifier         = "showAdvanceSegueIdentifier"
    static let showConfigureSegueIdentifier       = "showConfigureSegueIdentifier"
    static let showOptimizeSegueIdentifier        = "showOptimizeSegueIdentifier"
    static let showAddNewLocationSegueIdentifier  = "showAddNewLocationSegueIdentifier"
  }
  
  
}


// get ratio screen
struct RATIO {
  static let SCREEN_WIDTH               = (DeviceType.IPHONE_4_OR_LESS ? 1.0 : Screen.WIDTH / 375)
  static let SCREEN_HEIGHT              = (DeviceType.IPHONE_4_OR_LESS ? 1.0 : Screen.HEIGHT / 672.0)
  static let SCREEN                     = ((RATIO.SCREEN_WIDTH + RATIO.SCREEN_HEIGHT) / 2.0)
}

// get scale screen
struct ScaleValue {
  static let SCREEN_WIDTH         = (DeviceType.IPAD ? 1.8 : (DeviceType.IPHONE_6 ? 1.174 : (DeviceType.IPHONE_6P ? 1.295 : 1.0)))
  static let SCREEN_HEIGHT        = (DeviceType.IPAD ? 2.4 : (DeviceType.IPHONE_6 ? 1.171 : (DeviceType.IPHONE_6P ? 1.293 : 1.0)))
  static let FONT                 = (DeviceType.IPAD ? 1.5 : (DeviceType.IPHONE_6P ? 1.27 : (DeviceType.IPHONE_6 ? 1.15 : 1.0)))
}

// get screen size
struct Screen {
  static let BOUNDS   = UIScreen.mainScreen().bounds
  static let WIDTH    = UIScreen.mainScreen().bounds.size.width
  static let HEIGHT   = UIScreen.mainScreen().bounds.size.height
  static let MAX      = max(Screen.WIDTH, Screen.HEIGHT)
  static let MIN      = min(Screen.WIDTH, Screen.HEIGHT)
}

// get device type
struct DeviceType {
  static let IPHONE_4_OR_LESS  = UIDevice.currentDevice().userInterfaceIdiom == .Phone && Screen.MAX <  568.0
  static let IPHONE_5          = UIDevice.currentDevice().userInterfaceIdiom == .Phone && Screen.MAX == 568.0
  static let IPHONE_6          = UIDevice.currentDevice().userInterfaceIdiom == .Phone && Screen.MAX == 667.0
  static let IPHONE_6P         = UIDevice.currentDevice().userInterfaceIdiom == .Phone && Screen.MAX == 736.0
  static let IPAD              = UIDevice.currentDevice().userInterfaceIdiom == .Pad   && Screen.MAX == 1024.0
}

extension String {
  
  /*********************************************************/
  // MARK: Web service
  static let kDefineWebServiceAPIUrl              = "TEST"
  static let kDefineWebServiceResourcesUrl        = "TEST"
  
  /*********************************************************/
  // MARK: Font name
  
  static let kDefineFontNameLight  = "OpenSans-Light"
  static let kDefineFontNameNormal = "OpenSans"
  static let kDefineFontNameBold   = "OpenSans-Bold"
  
  // MARK: Social SDK AppID
  // Google Client ID
  static let kDefineGoogleClientID = "156546256887-fdnn8kil70eibpo321vkdekc628pdtqp.apps.googleusercontent.com"
  
  // Pinterest App ID
  static let kDefinePinterestAppID = "4851103225673166544"
  
  /*********************************************************/
  // MARK: Fabric
  static let kDefineTwitterConsumerKey = "G3TAxsEqr88vnEVi26nlTq4dI"//"gKWX00d0ez80oOobI68VKoGBH"
  static let kDefineTwitterSecrectKey = "qC7B60jEyBaym6YYEcP1a61xVpeHJJHtChXRWXXDLMOp2OQaCx"//"igjcmRTd450mNSTPsNrSKmUgKwty3NZv8XrlRvVFnUEmsF5l27"
  
  
  
  /*********************************************************/
  
  /*********************************************************/
  // MARK: Multi language
  
  static func MultiLanguage(key: String) -> String {
    return NSLocalizedString(key, comment: "")
  }
  
  static func convertObjectToJSONString (object: AnyObject) -> (String?) {
    do {
      let jsonData = try NSJSONSerialization.dataWithJSONObject(object, options: NSJSONWritingOptions.PrettyPrinted)
      return String(data: jsonData ,encoding: NSUTF8StringEncoding)!
    } catch let error as NSError {
      print(error.description)
    }
    return nil
  }
  
  static func toJSONString (object: AnyObject , options:NSJSONWritingOptions ) -> (String?) {
    do {
      let jsonData = try NSJSONSerialization.dataWithJSONObject(object, options: options)
      return String(data: jsonData ,encoding: NSUTF8StringEncoding)!
    } catch let error as NSError {
      print(error.description)
    }
    return nil
  }
  /*********************************************************/
}

// MARK: get ordinal number


func getFormatOrdinalNumber (number:Int) -> String {
  if number == 0 {
    return "0"
  }
  if (number > 3 && number < 21) {
    return "th"
  }
  let lastDigit  = number % 10
  switch (lastDigit) {
  case 1:  return "st"
  case 2:  return "nd"
  case 3:  return "rd"
  default: return "th"
  }
}


extension NSData {
  /**
   Convert NSData to Dictionary
   
   - returns: dictionary
   */
  func convertToDictionary() -> [String:AnyObject]? {
    do {
      return try NSJSONSerialization.JSONObjectWithData(self, options: []) as? [String:AnyObject]
    } catch let error as NSError {
      print(error)
    }
    return nil
  }
}


extension UIColor {
  class func kDefineDefaultGrayBackgroundColor() -> UIColor {
    return UIColor(red: 234.0/255.0, green: 234.0/255.0, blue: 234.0/255.0, alpha: 1.0)
  }
  
  class func kDefineDefaultRedBackgroundColor() -> UIColor {
    return UIColor(red: 234.0/255.0, green: 44.0/255.0, blue: 62.0/255.0, alpha: 1.0)
  }
}


extension UIStoryboard {
  
  class func instantiateFromStoryboard() -> Self
  {
    return instantiateFromStoryboardHelper(self, storyboardName: "Main")
  }
  
  class func instantiateFromStoryboard(storyboardName: String) -> Self
  {
    return instantiateFromStoryboardHelper(self, storyboardName: storyboardName)
  }
  
  private class func instantiateFromStoryboardHelper<T>(type: T.Type, storyboardName: String) -> T
  {
    var storyboardId = ""
    let components = "\(type.dynamicType)".componentsSeparatedByString(".")
    
    if components.count > 1
    {
      storyboardId = components[0]
    }
    let storyboad = UIStoryboard(name: storyboardName, bundle: nil)
    let controller = storyboad.instantiateViewControllerWithIdentifier(storyboardId) as! T
    
    return controller
  }
  
}

extension UIFont {
  class func kDefineDefaultFontLight(size: CGFloat) -> UIFont {
    return UIFont (name: String.kDefineFontNameLight, size: size)!
  }
  
  class func kDefineDefaultFontNormal(size: CGFloat) -> UIFont {
    return UIFont (name: String.kDefineFontNameNormal, size: size)!
  }
  
  class func kDefineDefaultFontBold(size: CGFloat) -> UIFont {
    return UIFont (name: String.kDefineFontNameBold, size: size)!
  }
  
}

extension CGFloat {
  static let kDefineFontSizeNormal: CGFloat = 13.0
  static let kDefineFontSizeTitle: CGFloat  = 15.0
  static let kDefineFontSizeDetail: CGFloat = 11.0
}

extension CGRect {
  static let kDefineHeightOfStatusBar = UIApplication.sharedApplication().statusBarFrame.size.height
  static let kDefineHeightOfMainScreen = UIScreen.mainScreen().bounds.size.height
  static let kDefineWidthOfMainScreen = UIScreen.mainScreen().bounds.size.width
}

extension NSDate {
  var age: Int {
    return NSCalendar.currentCalendar().components(.Year, fromDate: self, toDate: NSDate(), options: []).year
  }
}

extension UIUserInterfaceIdiom {
  
  static let kDefineIDIOM    = UIDevice.currentDevice().userInterfaceIdiom
  
  static let kDefineIsIpad   = { return UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad }
  static let kDefineIsIPhone = { return UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone }
}

extension UIUserInterfaceIdiom {
  static let kDefineIOSVersion = Int(UIDevice.currentDevice().systemVersion.componentsSeparatedByString(".")[0])
  
}

extension UITableView {
  func registerNib(cell: AnyObject) {
    
    let className = cell.theClassName
    
    let cellNib = UINib(nibName: className, bundle: nil)
    self.registerNib(cellNib, forCellReuseIdentifier: className)
  }
}

extension NSObject {
  var theClassName: String {
    return NSStringFromClass(self.dynamicType).componentsSeparatedByString(".").last!
  }
  
  func getClassName() -> String {
    return self.theClassName
  }
}

extension UITableViewCell {
  
  func setValueForBasicControl(outlets: NSArray, values:NSArray) {
    outlets.enumerateObjectsUsingBlock { (object, Indexable, stop) -> Void in
      
      let obj: AnyObject = object
      let className = obj.theClassName
      if (className.lowercaseString.rangeOfString("label") != nil) {
        let obj: UILabel = object as! UILabel
        obj.text = values[Indexable] as? String
      }
      else if (className.lowercaseString.rangeOfString("button") != nil) {
        let obj: UIButton = object as! UIButton
        obj.setTitle(values[Indexable] as? String, forState: UIControlState.Normal)
      }
      else if (className.lowercaseString.rangeOfString("textfield") != nil) {
        let obj: UITextField = object as! UITextField
        obj.text = values[Indexable] as? String
      }
      else if (className.lowercaseString.rangeOfString("textview") != nil) {
        let obj: UITextView = object as! UITextView
        obj.text = values[Indexable] as? String
      }
      else if (className.lowercaseString.rangeOfString("imageview") != nil) {
        let obj: UIImageView = object as! UIImageView
        obj.image = UIImage(named: (values[Indexable] as? String)!)
      }
    }
  }
}

protocol JSONAble {}

extension JSONAble {
  func toDict() -> [String:Any] {
    var dict = [String:Any]()
    let otherSelf = Mirror(reflecting: self)
    for child in otherSelf.children {
      if let key = child.label {
        dict[key] = child.value
      }
    }
    return dict
  }
}
extension NSObject {
  
  func JSONDictionary() -> [String : AnyObject] {
    var dict = Dictionary<String, Any>()
    
    let mirror = Mirror(reflecting: self)
    
    for child in mirror.children {
      if let key = child.label {
        dict[key] = child.value
      }
    }
    
    var result = [String: AnyObject]()
    for (key, value) in dict {
      if let v = value as? AnyObject {
        result[key] = v
      }
    }
    return result
  }
  
}

