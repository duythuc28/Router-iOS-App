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
  var ipAddress: String = ""
  var macAddress: String = ""
  init(name: String, ip: String, mac: String) {
    self.name = name
    self.ipAddress = ip
    self.macAddress = mac
    super.init()
  }
}