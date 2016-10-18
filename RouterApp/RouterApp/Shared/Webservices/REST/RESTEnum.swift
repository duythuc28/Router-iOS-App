//
//  UserAPI.swift
//  Swift_Core
//
//  Created by Canh on 1/5/16.
//  Copyright © 2016 iOS_Dev16. All rights reserved.
//

import UIKit
class RESTEnum: NSObject {
    
    enum StatusCode: NSInteger {
        case Success = 200
    }
    
    enum RequestMethod : String {
        case OPTIONS, GET, HEAD, POST, PUT, PATCH, DELETE, TRACE, CONNECT
    }
    
    enum Endcoding : String {
        case URL, JSON, CUSTOM
    }
}
