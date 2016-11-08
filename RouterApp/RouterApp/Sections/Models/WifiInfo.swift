//
//  WifiInfo.swift
//  RouterApp
//
//  Created by Phu Nguyen on 10/30/16.
//
//
import UIKit
import ObjectMapper
import RealmSwift

class ScanListResponse: Mappable {
  var wifis = [WifiInfo]()
  var originalWifi = [AnyObject]()
  convenience required init?(_ map: Map) {
    self.init()
  }
  
  func mapping(map: Map) {
    wifis    <- (map["result"])
    originalWifi <- map["result"]
  }
}

class WifiInfo: Mappable {
  dynamic var ssid: String = ""
  dynamic var bssid: String = ""
  dynamic var encryptionType: String = ""
  dynamic var password: String = ""
  dynamic var quality: Int = 0
  var encription: Encription = Encription()
  
  func mapping(map: Map) {
    ssid                              <- map["ssid"]
    bssid                             <- map["bssid"]
    quality                           <- map["quality"]
  }
  
  required convenience init?(_ map: Map) {
    self.init()
  }
}

class Encription: Mappable {
  var encripType: String = ""
  var enabled: Int = 0
  required convenience init?(_ map: Map) {
    self.init()
  }
  
  func mapping(map: Map) {
    encripType <- map["description"]
    enabled <- map["enable"]
  }
  
}
