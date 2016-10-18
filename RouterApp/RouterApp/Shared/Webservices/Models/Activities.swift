//
//  Activities.swift
//  Experfi
//
//  Created by Canh Tran on 5/14/16.
//  Copyright © 2016 Canh Tran. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class Activities: Object, Mappable {
    var objectID = 0
    dynamic var activity_type_id = ""
    dynamic var activity_name = ""
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    override class func primaryKey() -> String? {
        return "objectID"
    }
    
    func mapping(map: Map) {
        activity_type_id                        <- map["activity_type_id"]
        activity_name                           <- map["activity_name"]
    }
    //Incrementa ID
    func IncrementaID() -> Int{
        let realm = try! Realm()
        let RetNext: NSArray = Array(realm.objects(Activities).sorted("objectID"))
        let last = RetNext.lastObject
        if RetNext.count > 0 {
            let valor = last?.valueForKey("objectID") as? Int
            return valor! + 1
        } else {
            return 1
        }
    }
}
