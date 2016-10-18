//
//  Game.swift
//  Experfi
//
//  Created by Canh Tran on 4/16/16.
//  Copyright © 2016 Canh Tran. All rights reserved.
//

import UIKit
import ObjectMapper

final class Game: NSObject, Mappable {
    
    dynamic var item_id = ""
    dynamic var title = ""
    var details = [GameDetails]()
    dynamic var activity_type = ""
    dynamic var sequence: Int = 0
    
    dynamic var category_id = ""
    dynamic var price = ""
    dynamic var amount = ""
    dynamic var image = ""
    dynamic var keywords = ""
    dynamic var added_by = ""
    dynamic var added_on = NSDate()
    dynamic var total_rated = ""
    dynamic var total_rated_as_excited = ""
    dynamic var excite: CGFloat = 0
    dynamic var self_smart: CGFloat = 0
    dynamic var nature: CGFloat = 0
    dynamic var isHomeItem = ""
    dynamic var age_item_min = ""
    dynamic var player = ""
    dynamic var gender = ""
    dynamic var collected = ""
    dynamic var share = ""
    dynamic var intelligent_rating = ""
    dynamic var reviews = ""
    dynamic var tool = ""
    dynamic var licence = ""
    dynamic var p_type = ""
    dynamic var item_language_id = ""
    dynamic var people : CGFloat = 0
    dynamic var word : CGFloat = 0
    dynamic var body : CGFloat = 0
    dynamic var logic: CGFloat = 0
    dynamic var music :CGFloat = 0
    dynamic var picture : CGFloat = 0
    dynamic var total_methods = 0
    dynamic var isItemCollected = 0
    dynamic var exciting = ""
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        item_id                                 <- map["item_id"]
        sequence                                <- map["sequence"]
        title                                   <- map["title"]
        details                                 <- map["details"]
        total_methods                           <- map["total_methods"]
        category_id                             <- map["category_id"]
        price                                   <- map["price"]
        isHomeItem                              <- map["isHomeItem"]
        activity_type                           <- map["activity_type"]
        p_type                                  <- map["p_type"]
        word                                    <- map["Word"]
        item_id                                 <- map["item_id"]
        exciting                                <- map["exciting"]
        picture                                 <- map["Picture"]
        body                                    <- map["Body"]
        nature                                  <- map["Nature"]
        self_smart                              <- map["Self-Smart"]
        excite                                  <- map["excite"]
        amount                                  <- map["amount"]
        music                                   <- map["Music"]
        logic                                   <- map["Logic"]
        total_rated_as_excited                  <- map["total_rated_as_excited"]
        total_rated                             <- map["total_rated"]
        added_on                                <- map["added_on"]
        added_by                                <- map["added_by"]
        people                                  <- map["People"]
        keywords                                <- map["keywords"]
        image                                   <- map["image"]
        age_item_min                            <- map["age_item_min"]
        player                                  <- map["player"]
        gender                                  <- map["gender"]
        collected                               <- map["collected"]
        share                                   <- map["share"]
        intelligent_rating                      <- map["intelligent_rating"]
        exciting                                <- map["excite"]
        reviews                                 <- map["reviews"]
        tool                                    <- map["tool"]
        licence                                 <- map["licence"]
        item_language_id                        <- map["item_language_id"]
        isItemCollected                         <- map["isItemCollected"]

    }
}

struct GameDetails : Mappable
{
    var method = ""
    var total_steps = 0
    var steps = [Step]()
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        method      <- map["method"]
        total_steps <- map["total_steps"]
        steps       <- map["steps"]
    }
}

struct Step : Mappable
{
    var image = ""
    var youtube_url = ""
    var step = ""
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        image           <- map["image"]
        youtube_url     <- map["youtube_url"]
        step            <- map["step"]
    }
}

/*------------------------------------------------------*/
class SequenceData: NSObject {
    var kid_id : String = ""
    var activity_id  : String = ""
    var item_id   : String = ""
    var sequence   : Int = 0
    
    
    init (kid_id : String,activity_id: String, item_id: String, sequence: Int) {
        super.init()
        self.kid_id = kid_id
        self.activity_id  = activity_id
        self.item_id = item_id
        self.sequence   = sequence
    }
}



