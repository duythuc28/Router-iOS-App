//
//  Children.swift
//  Experfi
//
//  Created by Canh Tran on 3/6/16.
//  Copyright © 2016 Canh Tran. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

var currentKid = Kid()

class Kid: Object, Mappable {
    
    dynamic var objectID = 0
    dynamic var kid_id = ""
    dynamic var user_id = ""
    dynamic var firstname = ""
    dynamic var lastname = ""
//    dynamic var birthday = NSDate()
    dynamic var birthday = ""
    dynamic var gender = ""
    dynamic var added_on = NSDate()
    dynamic var added_by = 0
    //let owners = LinkingObjects(fromType: User.self, property: "kids")
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    override class func primaryKey() -> String? {
        return "objectID"
    }
    
    func mapping(map: Map) {
        kid_id                      <- map["kid_id"]
        user_id                     <- map["user_id"]
        firstname                   <- map["fname"]
        lastname                    <- map["lname"]
//        birthday                  <- (map["birthday"], DateTransform())
        birthday                    <- map["birthday"]
        gender                      <- map["gender"]
        added_on                    <- (map["added_on"], DateTransform())
    }
    //Incrementa ID
    func IncrementaID() -> Int{
        let realm = try! Realm()
        let RetNext: NSArray = Array(realm.objects(Kid).sorted("objectID"))
        let last = RetNext.lastObject
        if RetNext.count > 0 {
            let valor = last?.valueForKey("objectID") as? Int
            return valor! + 1
        } else {
            return 1
        }
    }
    
    func kidName() -> String {
        return firstname + " " + lastname
    }
    
    func updateKidInformation(kid: Kid) {
        dispatch_async(dispatch_queue_create("background", nil)) {
            let realm = try! Realm()
            let theKid = realm.objects(Kid.self).filter("kid_id = '\(kid.kid_id)'").first
            try! realm.write {
                theKid?.firstname = kid.firstname
                theKid?.lastname = kid.lastname
                theKid?.birthday = kid.birthday
                theKid?.gender = Gender.getTypeOfGenderByString(kid.gender)
            }
        }
    }
}
