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
  var wifis = List<WifiInfo>()
  
  convenience required init?(_ map: Map) {
    self.init()
  }
  
  func mapping(map: Map) {
    wifis    <- (map["result"], ListTransform<WifiInfo>())
  }
}

class WifiInfo: Object, Mappable {
  dynamic var ssid: String = ""
  dynamic var bssid: String = ""
  dynamic var encryptionType: String = ""
  dynamic var password: String = ""
  dynamic var quality: Int = 0
  var encription: Encription = Encription()
  
  func mapping(map: Map) {
    ssid                              <- map["ssid"]
    bssid                             <- map["bssid"]
    encription                        <- map["encryption"]
    quality                           <- map["quality"]
    encryptionType = encription.encripType
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
