//
//  APIParams.swift
//  Experfi
//
//  Created by iOSDev on 8/17/16.
//  Copyright © 2016 Canh Tran. All rights reserved.
//

import UIKit
import ObjectMapper

class APIParams: RESTParam {
  var method: String = ""
  var params: [AnyObject] = []
  
  convenience init(method mtd: String, params parameters: [AnyObject]) {
    self.init()
    self.method = mtd
    self.params = parameters
  }
  
  override init() {
    super.init()
  }
  
  required convenience init?(_ map: Map) {
    self.init()
  }
  
  override func mapping(map: Map) {
    method           <- map["method"]
    params           <- map["params"]
  }
}

class GetCPXDetailParams: RESTParam {
  var method: String
  var params: [String]
  
  override init() {
    method = "login"
    params = ["admin", "password"]
    super.init()
  }
  
  required convenience init?(_ map: Map) {
    self.init()
  }
  
  override func mapping(map: Map) {
    method           <- map["method"]
    params           <- map["params"]
  }
}