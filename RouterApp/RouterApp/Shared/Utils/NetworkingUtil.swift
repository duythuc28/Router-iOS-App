//
//  Networking.swift
//  SGDrivers
//
//  Created by Nhan Nguyen on 9/4/15.
//  Copyright (c) 2015 Nhan Nguyen. All rights reserved.
//

import UIKit
import Reachability
import SystemConfiguration.CaptiveNetwork


class NetworkingUtil: NSObject {
  
  class func isHavingNetworkConnection() -> Bool {
    let reachability: Reachability = Reachability.reachabilityForInternetConnection()
    let networkStatus: NetworkStatus = reachability.currentReachabilityStatus()
    
    if (networkStatus == NetworkStatus.NotReachable) {
      return false
    }
    
    return true
  }
  
  class func fetchSSIDInfo() -> String {
    var currentSSID = ""
    if let interfaces = CNCopySupportedInterfaces() {
      for i in 0..<CFArrayGetCount(interfaces) {
        let interfaceName: UnsafePointer<Void> = CFArrayGetValueAtIndex(interfaces, i)
        let rec = unsafeBitCast(interfaceName, AnyObject.self)
        let unsafeInterfaceData = CNCopyCurrentNetworkInfo("\(rec)")
        if unsafeInterfaceData != nil {
          let interfaceData = unsafeInterfaceData! as Dictionary!
          currentSSID = interfaceData["SSID"] as! String
        }
      }
    }
    return currentSSID
  }
  
}
