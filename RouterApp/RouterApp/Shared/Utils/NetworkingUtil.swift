//
//  Networking.swift
//  SGDrivers
//
//  Created by Nhan Nguyen on 9/4/15.
//  Copyright (c) 2015 Nhan Nguyen. All rights reserved.
//

import UIKit
import Reachability

class NetworkingUtil: NSObject {
    
    class func isHavingNetworkConnection() -> Bool {
        let reachability: Reachability = Reachability.reachabilityForInternetConnection()
        let networkStatus: NetworkStatus = reachability.currentReachabilityStatus()
        
        if (networkStatus == NetworkStatus.NotReachable) {
            return false
        }
        
        return true
    }
}
