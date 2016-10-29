//
//  CPXDevice.swift
//  RouterApp
//
//  Created by Phu Nguyen on 10/25/16.
//
//

import Foundation
import ObjectMapper
import RealmSwift

class CPXDevice: NSObject {
  var name: String  = ""
  var location: String = ""
  var clients: [CPXClientInfo] = [CPXClientInfo]()
  var ipAddress: String = ""
  var macAddress: String? = ""
  var quality: Int = 0
  var status: Bool = false
  var configured: Bool = false
  var hasConfigInfo: Bool = false
  var token: String = ""
  init(name: String, ip: String, mac: String?) {
    self.name = ip
    self.ipAddress = ip
    self.macAddress = mac
    super.init()
  }
  
  func updateInfo(info: AnyObject?) {
    // parse result to device
    guard let result = info else {
      // Show error message
      return
    }
    guard let respsonse = result["result"] as? [String: AnyObject] else {
      return
    }
    self.configured = true // get cpx info -> set config == true
    if let status = respsonse["is_up"] as? Int {
      self.status = status > 0 ? true : false
    }
    if let location = respsonse["is_up"] as? String {
      self.location = location
    }
    if let quality = respsonse["quality"] as? Int {
      self.quality = quality
    }
    if let location = respsonse["location"] as? String {
      self.location = location
    }
    if let config = respsonse["config"] as? [String: AnyObject] where config.count > 0 {
      self.hasConfigInfo = true
    }
    guard let clients = respsonse["clients"] as? [String: AnyObject] where clients.count > 0 else {
      return
    }
    self.clients.removeAll()
    for (key, value) in clients {
      let client = CPXClientInfo(name: key, mac: key, ip: "")
      self.clients.append(client)
      guard let ip = value["lastip"] as? String else {
        return
      }
      client.ipAddress = ip
    }
  }
  
}

class CPXClientInfo: NSObject {
  var name: String = ""
  var macAddress: String = ""
  var ipAddress: String = ""
  
  convenience init(name: String, mac: String, ip: String) {
      self.init()
    self.name = name
    self.ipAddress = ip
    self.macAddress = mac
  }
  
}