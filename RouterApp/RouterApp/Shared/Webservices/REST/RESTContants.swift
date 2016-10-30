//
//  RESTContants.swift
//  9Gags
//
//  Created by iOs_Dev on 1/8/16.
//  Copyright © 2016 Duong Tran. All rights reserved.
//

import Foundation
import SwiftyJSON
import CoreLocation

class RESTContants: NSObject {

  //MARK: RESTRequest Header Keys
  static let RequestHeaderKey                   = "Header"
  static let RequestAuthorizationKey            = "Authorization"
  static let RequestContentTypeKey              = "Content-Type"
  static let RequestAcceptKey                   = "Accept"
  static let Headers                            = ["Content-Type" : "application/json"]
  static let PrefixToken                        = "Bearer "

  //MARK: Keys for parser
  static let SuccessKeyFromResponseData         = "status"
  static let MessageKeyFromResponseData         = "error"
  static let DefaultMessageKeyFromResponseData  = "unknow_error"

  //MARK: Prepairing request
  static let RequestTimeOut                     = 90.0
  static let StatusCodeSuccess                  = 200

  //MARK: Webservice url
//  static let WebserviceUrl                      = "http://dliver.local.sutrix.com/api/"
  static let WebserviceUrl                      = "https://dliver.local.sutrix.com/api/"
  static let HostName                           = "dliver.local.sutrix.com"
  static let WebserviceResourceUrl              = ""
  static let kAuthenticate = "/cgi-bin/luci/rpc/auth"
  static let kGetCPXDetail = "/cgi-bin/luci/rpc/mesh?auth="
  static let kSetCPXInfo = "/cgi-bin/luci/rpc/mesh?auth="
  static let kRebootCPX = "/cgi-bin/luci/rpc/sys?auth="
  static let kGetWifiNetworks = "/cgi-bin/luci/rpc/mesh?auth="
  static let kConfigureCPX = "/cgi-bin/luci/rpc/mesh?auth="
}
