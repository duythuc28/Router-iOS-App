//
//  Parent.swift
//  Experfi
//
//  Created by Canh Tran on 3/6/16.
//  Copyright © 2016 Canh Tran. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class User: Object, Mappable {
    
    dynamic var objectID = 0
    dynamic var user_id = 0
    dynamic var fullname = ""
    dynamic var firstname = ""
    dynamic var lastname = ""
    dynamic var birthday = NSDate()
    dynamic var email = ""
    dynamic var password = ""
    dynamic var gender = ""
    dynamic var phone = ""
    dynamic var passcode = ""
    dynamic var item_collected = "0"
    dynamic var dated = NSDate()
    dynamic var img_thumb = ""
    dynamic var img = ""
    dynamic var status = true
    //let kids = List<Kid>()
    dynamic  var token = ""
    dynamic  var message = ""
    var HTTP_response_code = 0
    dynamic var appVersion = ""
    dynamic var login_counter = 0
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    override class func primaryKey() -> String? {
       return "objectID"
    }
    
    func mapping(map: Map) {
        user_id                 <- map["user_id"]
        firstname               <- map["fname"]
        lastname                <- map["lname"]
        email                   <- map["email"]
        gender                  <- map["gander"]
        item_collected          <- map["item_collected"]
        phone                   <- map["phone"]
        status                  <- map["status"]
        token                   <- map["token"]
        message                 <- map["message"]
        HTTP_response_code      <- map["HTTP_response_code"]
        appVersion              <- map["app_version"]
        login_counter           <- map["login_counter"]
    }
    
    //Incrementa ID
    func IncrementaID() -> Int{
        let realm = try! Realm()
        let RetNext: NSArray = Array(realm.objects(User).sorted("objectID"))
        let last = RetNext.lastObject
        if RetNext.count > 0 {
            let valor = last?.valueForKey("objectID") as? Int
            return valor! + 1
        } else {
            return 1
        }
    }
    
    func updateUserInformation (updateUser: User) {
        let realm = try! Realm()
        try! realm.write {
            self.firstname = updateUser.firstname
            self.lastname = updateUser.lastname
            self.birthday = updateUser.birthday
            self.token = updateUser.token
            self.password = updateUser.password
            self.email = updateUser.email
        }
    }
}
