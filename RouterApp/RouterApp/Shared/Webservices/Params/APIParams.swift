//
//  APIParams.swift
//  Experfi
//
//  Created by iOSDev on 8/17/16.
//  Copyright © 2016 Canh Tran. All rights reserved.
//

import UIKit
import ObjectMapper

class UpdateUserParams: NSObject, Mappable {
    
    var token = ""
    var firstName = ""
    var lastName = ""
    var phoneNumber = ""
    var year = ""
    var oldPassword = ""
    var newPassword = ""
    var confirmPassword = ""
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    
    
    func setupData(token: String , firstName : String , lastName : String , phoneNumber:String, year : String , oldPassword : String, newPassword : String, confirmPassword : String) {
        self.token = token
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.year = year
        self.oldPassword = oldPassword
        self.newPassword = newPassword
        self.confirmPassword = confirmPassword
    }
    
    func mapping(map: Map) {
        token           <- map["token"]
        firstName       <- map["fname"]
        lastName        <- map["lname"]
        phoneNumber     <- map["phone_no"]
        year            <- map["year"]
        oldPassword     <- map["old_password"]
        newPassword     <- map["new_password"]
        confirmPassword <- map["confirm_new_password"]
    }
}