//
//  Rating.swift
//  Experfi
//
//  Created by Canh Tran on 6/21/16.
//  Copyright © 2016 Canh Tran. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class RatingData: NSObject, Mappable {
    var item_id : String = ""
    var title  : String = ""
    var text   : String = ""
    var reviews   : String = ""
    var review_id   : String = ""
    var fname   : String = ""
    var lname   : String = ""
    var user_id   : String = ""
    var exciting   : String = "0"
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        item_id                                 <- map["item_id"]
        title                                   <- map["title"]
        text                                    <- map["text"]
        reviews                                 <- map["reviews"]
        review_id                               <- map["review_id"]
        fname                                   <- map["fname"]
        lname                                   <- map["lname"]
        user_id                                 <- map["user_id"]
        exciting                                <- map["exciting"]
    }
}


struct Rating {

    static let rate_item = "rate_item"
    static let exciting_item = "exciting_item"
    static let comment_item = "comment_item"
    static let token = "token"
    
    static let intelligent_rating = "intelligent_rating"
    static let identification_point = "identification_point"
    static let item_id = "item_id"
    static let review = "review"
    

}