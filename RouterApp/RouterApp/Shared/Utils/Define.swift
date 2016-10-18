//
//  Define.swift
//  Swift_Core
//
//  Created by iOS_Dev16 on 1/4/16.
//  Copyright © 2016 iOS_Dev16. All rights reserved.
//

import UIKit

/*-----------------------------------------*/
// AppDelegate
let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

/*-----------------------------------------*/
let searchPlaceHolder = "Nhập từ khoá"

/*-----------------------------------------*/
let defaultColorApp = UIColor(red: 44.0/255.0, green: 153.0/255.0, blue: 52.0/255.0, alpha:1.0)
let defaultTextColor = UIColor(red: 102.0/255.0, green: 102/255.0, blue: 102/255.0, alpha:1.0)
let defaultBackgroundFilterView = UIColor(red: 248/255.0, green: 248/255.0, blue: 248/255.0, alpha:1.0)

/*-----------------------------------------*/
// Utils through app
let WIDTH = UIScreen.mainScreen().bounds.size.width
let HEIGHT = UIScreen.mainScreen().bounds.size.height
let RATIO_HEIGHT = getRatioHeight()
let RATIO_WIDTH = getRatioWidth()
let SCREEN_BOUNDS =  UIScreen.mainScreen().bounds
// Use for test UI without API
let testVersion = 1
let MAXIMUM_KID_NUMBER = 7

/*-----------------------------------------*/
// Object Search
let searchPlace = ["label_psubject_indoor".localized,
                   "label_psubject_bedtime".localized,
                   "label_psubject_bathtime".localized,
                   "label_psubject_mealtime".localized,
                   "label_psubject_outdoor".localized,
                   "label_psubject_roadtrip".localized,
                   "label_psubject_atrest".localized,
                   "label_psubject_busykid".localized]
let searchAge = ["text_details_age_newborn".localized,
                 "3+ \("text_details_age_month".localized)",
                 "6+ \("text_details_age_month".localized)",
                 "9+ \("text_details_age_month".localized)",
                 "1+ \("text_details_age_year".localized)",
                 "15+ \("text_details_age_month".localized)",
                 "18+ \("text_details_age_month".localized)",
                 "21+  \("text_details_age_month".localized)",
                 "2+ \("text_details_age_years".localized)",
                 "3+ \("text_details_age_years".localized)",
                 "4+ \("text_details_age_years".localized)",
                 "5+ \("text_details_age_years".localized)"]

let searchGender = ["text_search_all".localized,
                    "text_details_gender_female".localized,
                    "text_details_gender_male".localized,
                    "text_details_gender_other".localized]
let searchPlayer = ["1+", "2+", "3+", "4+", "5+", "6+"]
let searchTools = ["label_details_tool".localized, "text_details_tools_notool".localized]
let searchPrice = ["text_details_license_free".localized, "Paid"]
let searchIntelligences = ["label_isubject_body".localized,
                           "label_isubject_word".localized,
                           "label_isubject_people".localized,
                           "label_isubject_logic".localized,
                           "label_isubject_picture".localized,
                           "label_isubject_music".localized,
                           "label_isubject_nature".localized,
                           "label_isubject_selfsmart".localized]

// KEY_CACHE_USERDEFAULT
let NUMBER_LOGIN = "NUMBER_LOGIN"

/*-----------------------------------------*/
// String login
func MULTILANGUAGE(key: String) -> String
{
    return NSLocalizedString(key, comment: "Title")
}


/*-----------------------------------------*/
// Check version IOS
func SYSTEM_VERSION_EQUAL_TO(version: NSString) -> Bool {
    return UIDevice.currentDevice().systemVersion.compare(version as String, options: NSStringCompareOptions.NumericSearch) == NSComparisonResult.OrderedSame
}

func SYSTEM_VERSION_GREATER_THAN(version: NSString) -> Bool {
    return UIDevice.currentDevice().systemVersion.compare(version as String, options: NSStringCompareOptions.NumericSearch) == NSComparisonResult.OrderedDescending
}

func SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(version: NSString) -> Bool {
    return UIDevice.currentDevice().systemVersion.compare(version as String, options: NSStringCompareOptions.NumericSearch) != NSComparisonResult.OrderedAscending
}

func SYSTEM_VERSION_LESS_THAN(version: NSString) -> Bool {
    return UIDevice.currentDevice().systemVersion.compare(version as String, options: NSStringCompareOptions.NumericSearch) == NSComparisonResult.OrderedAscending
}

func SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(version: NSString) -> Bool {
    return UIDevice.currentDevice().systemVersion.compare(version as String, options: NSStringCompareOptions.NumericSearch) != NSComparisonResult.OrderedDescending
}


func isIphone4() -> Bool
{
    if UIDevice().userInterfaceIdiom == .Phone {
        if UIScreen.mainScreen().nativeBounds.height == 960
        {
            return true
        }
    }
    return false
}

func isIphone5() -> Bool
{
    if UIDevice().userInterfaceIdiom == .Phone {
        if UIScreen.mainScreen().nativeBounds.height == 1136
        {
            return true
        }
    }
    return false
}

func isIphone6() -> Bool
{
    if UIDevice().userInterfaceIdiom == .Phone {
        if UIScreen.mainScreen().nativeBounds.height == 1334
        {
            return true
        }
    }
    return false
}

func isIphone6Plush() -> Bool
{
    if UIDevice().userInterfaceIdiom == .Phone {
        if UIScreen.mainScreen().nativeBounds.height == 2208
        {
            return true
        }
    }
    return false
}

func getRatioHeight() -> CGFloat
{
    if isIphone4()
    {
        return 1
    }
    else
    {
        let ratio = UIScreen.mainScreen().bounds.size.height / (DeviceType.IPAD == true ? 2048 : 568)
        return ratio > 2 ? 1.8 : ratio
    }
}
func getRatioWidth() -> CGFloat
{
    if isIphone4()
    {
        return 1
    }
    else
    {
        let ratio = UIScreen.mainScreen().bounds.size.width / (DeviceType.IPAD == true ? 640 : 320)
        return ratio > 1.8 ? 1.5 : ratio
    }
}