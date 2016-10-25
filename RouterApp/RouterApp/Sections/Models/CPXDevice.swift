//
//  CPXDevice.swift
//  RouterApp
//
//  Created by Phu Nguyen on 10/25/16.
//
//

import Foundation

class CPXDevice: NSObject {
  var name: String  = ""
  var location: String = ""
  var clients: [CPXClientInfo]
  var ipAddress: String = ""
  var macAddress: String? = ""
  var quality: String = ""
  var status: Bool = true
  var configured: Bool = false
  init(name: String, ip: String, mac: String?) {
    self.clients = [CPXClientInfo(), CPXClientInfo(), CPXClientInfo(), CPXClientInfo()]
    self.name = ip
    self.ipAddress = ip
    self.macAddress = mac
    self.quality = "Online: 96%"
    self.location = "Office"
    super.init()
  }
}

class CPXClientInfo: NSObject {
  var name: String = ""
  var macAddress: String = ""
  var ipAddress: String = ""
  override init() {
    self.name = "MimoSeries2"
    self.macAddress = "D4:F4:6F:C9:3F"
    self.ipAddress = "192.168.1.104"
    super.init()
  }
  
  convenience init(name: String, mac: String, ip: String) {
      self.init()
    self.name = name
    self.ipAddress = ip
    self.macAddress = mac
  }
}