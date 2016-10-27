//
//  DLCache.swift
//  Dliver
//
//  Created on 7/11/16.
//

import UIKit

class Cache: NSObject {
  static let sharedCache = Cache()
  private let userDefaults = NSUserDefaults.standardUserDefaults()

  func setObject(obj: AnyObject, forKey key: String) {
    let data = NSKeyedArchiver.archivedDataWithRootObject(obj)
    userDefaults.setObject(data, forKey: key)
    userDefaults.synchronize()
  }

  func getObject(forKey key: String) -> AnyObject? {
    if let data = userDefaults.objectForKey(key) as? NSData {
      return NSKeyedUnarchiver.unarchiveObjectWithData(data)
    } else {
      return nil
    }
  }

}
