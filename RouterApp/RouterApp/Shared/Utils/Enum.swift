//
//  Enum.swift
//  SGDrivers
//
//  Created by Tran Duong on 9/6/15.
//  Copyright (c) 2015 Nhan Nguyen. All rights reserved.
//

import UIKit


enum Gender: String
{
    case m = "Male"
    case f = "Female"
    case a = "All"
    
    static func getGenderType(type : String) -> String
    {
        switch type {
        case "m":
            return "text_details_gender_male".localized
        case "f":
            return "text_details_gender_female".localized
        case "a" :
            return "text_details_gender_other".localized
        default:
            return "None"
        }
    }
    
    static func getTypeOfGenderByString(string: String) -> String
    {
        if string == "text_details_gender_male".localized
        {
            return "m"
        }
        else if string == "text_details_gender_female".localized
        {
            return "f"
        }
        else {
            return "a"
        }
    }
}


enum MenuItem : String {
    case Home = "Home page"
    case About = "About Experfi team"
    case Theory = "Experfi’s theory"
    case ManageActivities = "Manage activities"
    case EditLanguage = "Edit Language"
    case TermAndPolicies = "Terms & Policies"
    case Share = "Share this app"
    case Feedback = "Send us feedback/report"
    case RemoveAds = "Remove ads"
    case SignOut = "Sign out"
    
    static func menuWithString(menuTitle: String)->MenuItem {
        switch menuTitle {
        case "Home page":
            return .Home
        case "label_leftmenu_aboutexperfi".localized:
            return .About
        case "label_leftmenu_theory".localized:
            return .Theory
        case "label_leftmenu_activity".localized:
            return .ManageActivities
        case "label_leftmenu_language".localized:
            return .EditLanguage
        case "label_leftmenu_termpolicy".localized:
            return .TermAndPolicies
        case "label_leftmenu_share".localized:
            return .Share
        case "label_leftmenu_feedback".localized:
            return .Feedback
        case "label_leftmenu_removeads".localized:
            return .RemoveAds
        case "label_leftmenu_logout".localized:
            return .SignOut
        default:
            return .Home
        }
    }
}

enum TypeStore: String
{
    case Default = "default"
    case All    = "all"
    case FirstKid = "fistkid"
    case Category = "category"
    case Parenting = "parenting"
}

enum TypeActivity: String
{
    case Indoor = "Indoor"
    case Outdoor = "Outdoor"
    case Bedtime = "Bedtime"
    case Mealtime = "Mealtime"
    case RoadTrip = "Road Trip"
    case BusyKid = "Busy Kid"
    case Waiting = "Waiting"
    case BathTime = "Bath Time"
    
    
    var activityID : Int {
        switch self {
        case .Indoor:
            return 1
        case .Outdoor:
            return 2
        case .Bedtime:
            return 3
        case .Mealtime:
            return 4
        case .RoadTrip:
            return 5
        case .BusyKid:
            return 7
        case .Waiting:
            return 8
        case .BathTime:
            return 9
        }
    }
    
    static let listActivities = ["label_psubject_indoor".localized, "label_psubject_outdoor".localized, "label_psubject_bedtime".localized, "label_psubject_mealtime".localized, "label_psubject_roadtrip".localized, "label_psubject_busykid".localized, "label_psubject_atrest".localized, "label_psubject_bathtime".localized]
    
    static func getActivityID(activityString :String) -> String {
        switch activityString {
        case "label_psubject_indoor".localized :
            return 1.description
        case  "label_psubject_outdoor".localized :
            return 2.description
        case "label_psubject_bedtime".localized :
            return 3.description
        case  "label_psubject_mealtime".localized :
            return 4.description
        case  "label_psubject_roadtrip".localized:
            return 5.description
        case  "label_psubject_busykid".localized :
            return 7.description
        case  "label_psubject_atrest".localized :
            return 8.description
        case  "label_psubject_bathtime".localized :
            return 9.description
        default :
            return 1.description
        }
    }
    
    static func getActivityName(activityID :String) -> String {
        switch activityID {
        case 1.description :
            return "label_psubject_indoor".localized
        case  2.description :
            return "label_psubject_outdoor".localized
        case  3.description :
            return "label_psubject_bedtime".localized
        case  4.description:
            return "label_psubject_mealtime".localized
        case  5.description:
            return "label_psubject_roadtrip".localized
        case  7.description :
            return  "label_psubject_busykid".localized
        case  8.description :
            return "label_psubject_atrest".localized
        case 9.description :
            return "label_psubject_bathtime".localized
        default :
            return 1.description
        }
    }
}


enum TypeRating: String
{
    case Body = "Body"
    case Word = "Word"
    case People = "People"
    case Music = "Music"
    case Picture = "Picture"
    case Self_Smart = "Self-Smart"
    case Nature = "Nature"
    case Logic = "Logic"
    
    
    var ratingID : Int {
        switch self {
        case .Body:
            return 1
        case .Word:
            return 2
        case .People:
            return 3
        case .Music:
            return 4
        case .Picture:
            return 5
        case .Self_Smart:
            return 6
        case .Nature:
            return 7
        case .Logic:
            return 8
        }
    }
    
    static let listRating = ["label_isubject_body".localized,
                             "label_isubject_word".localized,
                             "label_isubject_people".localized,
                             "label_isubject_logic".localized,
                             "label_isubject_picture".localized,
                             "label_isubject_music".localized ,
                             "label_isubject_nature".localized,
                             "label_isubject_selfsmart".localized]
    
    static func getRatingID(activityString :String) -> String {
        switch activityString {
        case "label_isubject_body".localized :
            return 1.description
        case  "label_isubject_word".localized :
            return 2.description
        case  "label_isubject_people".localized :
            return 3.description
        case  "label_isubject_music".localized :
            return 4.description
        case  "label_isubject_picture".localized:
            return 5.description
        case  "label_isubject_selfsmart".localized :
            return 6.description
        case  "label_isubject_nature".localized :
            return 7.description
        case  "label_isubject_logic".localized :
            return 8.description
        default :
            return 1.description
        }
    }
    
    static func getActivityName(activityID :String) -> String {
        switch activityID {
        case 1.description :
            return "label_isubject_body".localized
        case  2.description :
            return "label_isubject_word".localized
        case  3.description :
            return "label_isubject_people".localized
        case  4.description:
            return "label_isubject_music".localized
        case  5.description:
            return "label_isubject_picture".localized
        case  6.description :
            return  "label_isubject_selfsmart".localized
        case  7.description :
            return "label_isubject_nature".localized
        case 8.description :
            return "label_isubject_logic".localized
        default :
            return 1.description
        }
    }
    
}

enum TypeParenting: String
{
    case Parents = "Parents"
    case Father = "Father"
    case Mother = "Mother"
    case Single_Mom = "Single Mom"
    
    static var listTypeParenting = ["label_parenting_parent".localized, "label_parenting_mother".localized, "label_parenting_sinlgemom".localized, "label_parenting_father".localized]
    
    func type_parenting(parentName: String) -> TypeParenting {
        switch parentName {
        case "label_parenting_parent".localized:
            return .Parents
        case "label_parenting_mother".localized:
            return .Father
        case "label_parenting_sinlgemom".localized:
            return .Mother
        case "label_parenting_father".localized:
            return .Single_Mom
        default: return .Parents
        }
        
    }
    
    func type_parenting_ID() -> String {
        switch self {
        case TypeParenting.Parents:
            return "10"
        case TypeParenting.Father:
            return "11"
        case TypeParenting.Mother:
            return "12"
        case TypeParenting.Single_Mom:
            return "13"
        }
        
    }
}

