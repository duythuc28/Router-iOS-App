//
//  Category.swift
//  Experfi
//
//  Created by Canh Tran on 4/10/16.
//  Copyright © 2016 Canh Tran. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class Category: Object, Mappable {

    dynamic var objectID = 0
    dynamic var category_id = ""
    dynamic var category_name = ""
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    override class func primaryKey() -> String? {
        return "objectID"
    }
    
    func mapping(map: Map) {
        category_id                             <- map["category_id"]
        category_name                           <- map["category_name"]
    }

    //Incrementa ID
    func IncrementaID() -> Int{
        let realm = try! Realm()
        let RetNext: NSArray = Array(realm.objects(Category).sorted("objectID"))
        let last = RetNext.lastObject
        if RetNext.count > 0 {
            let valor = last?.valueForKey("objectID") as? Int
            return valor! + 1
        } else {
            return 1
        }
    }
}

//
//class ListTransform<T:RealmSwift.Object where T:Mappable> : TransformType {
//    typealias Object = List<T>
//    typealias JSON = [AnyObject]
//    
//    let mapper = Mapper<T>()
//    
//    func transformFromJSON(value: AnyObject?) -> Object? {
//        let results = List<T>()
//        if let value = value as? [AnyObject] {
//            for json in value {
//                if let obj = mapper.map(json) {
//                    results.append(obj)
//                }
//            }
//        }
//        return results
//    }
//    
//    func transformToJSON(value: Object?) -> JSON? {
//        var results = [AnyObject]()
//        if let value = value {
//            for obj in value {
//                let json = mapper.toJSON(obj)
//                results.append(json)
//            }
//        }
//        return results
//    }
//}