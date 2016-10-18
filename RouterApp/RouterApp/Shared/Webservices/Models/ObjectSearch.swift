//
//  ObjectSearch.swift
//  Experfi
//
//  Created by Canh Tran on 4/16/16.
//  Copyright © 2016 Canh Tran. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

enum EnumObjectSearch: String {
    case Gender = "Gender"
    case Player = "Player"
    case Age = "Age"
    case Tools = "Tools"
    case Price = "Price"
    case Place = "Place"
    case Keyword = "Keyword"
    case Intelligences = "Intelligences"
    
    static let allValues = [Gender, Player, Age, Tools, Price, Place, Intelligences]
}

class ObjectSearch: Object, Mappable {

    dynamic var objectID = 0
    dynamic var id = ""
    dynamic var name_vn = ""
    dynamic var name_en = ""
    dynamic var num = ""
    dynamic var active = ""
    dynamic var type = ""
    
    // For Intelligences
    dynamic var content_en = ""
    dynamic var content_vn = ""
    
    override class func primaryKey() -> String? {
        return "objectID"
    }
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id                      <- map["id"]
        name_vn                 <- map["name_vn"]
        name_en                 <- map["name_en"]
        num                     <- map["num"]
        active                  <- map["active"]
        content_en              <- map["content_vn"]
        content_en              <- map["content_vn"]
    }
    
    //Incrementa ID
    func IncrementaID() -> Int{
        let realm = try! Realm()
        let RetNext: NSArray = Array(realm.objects(ObjectSearch).sorted("objectID"))
        let last = RetNext.lastObject
        if RetNext.count > 0 {
            let valor = last?.valueForKey("objectID") as? Int
            return valor! + 1
        } else {
            return 1
        }
    }
}

