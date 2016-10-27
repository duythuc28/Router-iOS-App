

import UIKit
import ObjectMapper
import RealmSwift

class Location: Object {
//  var objectID = 0
  dynamic var name = ""
  dynamic var createdAt = NSDate()
  
  convenience init(locationName name: String, date: NSDate = NSDate()) {
    self.init()
    self.name = name
  }
  
//  override class func primaryKey() -> String? {
//    return "objectID"
//  }
  
  //Incrementa ID
//  func IncrementaID() -> Int{
//    let RetNext: NSArray = Array(realmDB.objects(Location).sorted("objectID"))
//    let last = RetNext.lastObject
//    if RetNext.count > 0 {
//      let valor = last?.valueForKey("objectID") as? Int
//      return valor! + 1
//    } else {
//      return 1
//    }
//  }
}
