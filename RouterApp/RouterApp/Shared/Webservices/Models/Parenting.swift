//
//  Parenting.swift
//  Experfi
//
//  Created by Canh Tran on 8/20/16.
//  Copyright © 2016 Canh Tran. All rights reserved.
//

import UIKit
import ObjectMapper

final class Parenting: NSObject, Mappable {
    
    dynamic var item_id = ""
    dynamic var title = ""
    var details = [ParentingDetails]()
    dynamic var activity_type = ""
    dynamic var sequence: Int = 0
    
    dynamic var price = ""
    dynamic var amount = ""
    dynamic var image = ""
    dynamic var keywords = ""
    dynamic var added_by = ""
    dynamic var added_on = ""
    dynamic var p_type = ""
    dynamic var item_language_id = ""
    dynamic var isItemCollected = 0

    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        item_id                                 <- map["item_id"]
        sequence                                <- map["sequence"]
        title                                   <- map["title"]
        details                                 <- map["details"]
        price                                   <- map["price"]
        activity_type                           <- map["activity_type"]
        p_type                                  <- map["p_type"]
        amount                                  <- map["amount"]
        added_on                                <- map["added_on"]
        added_by                                <- map["added_by"]
        keywords                                <- map["keywords"]
        image                                   <- map["image"]
        item_language_id                        <- map["item_language_id"]
        isItemCollected                         <- map["isItemCollected"]
        
    }
}

struct ParentingDetails : Mappable
{

    var component = [Component]()
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        component        <- map["detail"]
    }
}

struct Component : Mappable
{
    var text = ""
    var image = ""
    
    init?(_ map: Map) {
    }
    
    mutating func mapping(map: Map) {
        text        <- map["text"]
        image       <- map["image"]
    }
}
