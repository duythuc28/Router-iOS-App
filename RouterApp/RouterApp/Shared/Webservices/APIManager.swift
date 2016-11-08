//
//  APIManager.swift
//  RouterApp
//
//  Created by Phu Nguyen on 10/26/16.
//
//

import Foundation
import Alamofire
import RealmSwift
import ObjectMapper

class APIManager: NSObject {
  
  // Authentication request
  static func authenticateRouter(withIP ipAddress: String, completion:((token: String?, error: RESTError?) -> Void)) {
    let path = String(format: "http://%@%@", ipAddress, RESTContants.kAuthenticate)
    let request = RESTRequest(url: path, functionName: "", method: .POST, endcoding: .JSON)
    let params = APIParams(method: "login", params: ["admin", "password"])
    request.setQueryParam(params)
    request.baseInvokerWithHeaderResponse { (result, error) in
      if result != nil {
        if let token = result!["result"] as? String {
          completion(token: token, error: nil)
        }
      }
      else {
        completion(token: "", error: error)
      }
    }
  }
  
  static func getCPXDetail(withIP ipAddress: String, token: String, completion:((result: AnyObject?, error: RESTError?) -> Void)) {
    let path = String(format: "http://%@%@%@", ipAddress, RESTContants.kGetCPXDetail, token)
    let request = RESTRequest(url: path, functionName: "", method: .POST, endcoding: .JSON)
    let params = APIParams(method: "get_info", params: [])
    request.setQueryParam(params)
    request.baseInvokerWithHeaderResponse { (result, error) in
      if result != nil {
        completion(result: result, error: nil)
      }
      else {
        completion(result: nil, error: error)
      }
    }
  }
  
  static func updateCPXInfo(withName name: String, location: String, completion:((result: AnyObject?, error: RESTError?) -> Void)) {
    let info = getAddressAndToken()
    
    let path = String(format: "http://%@%@%@", info.ip, RESTContants.kSetCPXInfo, info.token)
    let request = RESTRequest(url: path, functionName: "", method: .POST, endcoding: .JSON)
    var paramDict = [String: String]()
    paramDict["name"] = name
    paramDict["location"] = location
    let params = APIParams(method: "set_info", params: [paramDict])
    request.setQueryParam(params)
    request.baseInvokerWithHeaderResponse { (result, error) in
      if result != nil {
        completion(result: result, error: nil)
      }
      else {
        completion(result: nil, error: error)
      }
    }
  }
  
  static func rebootCPX(completion:((result: AnyObject?, error: RESTError?) -> Void)) {
    let info = getAddressAndToken()
    let path = String(format: "http://%@%@%@", info.ip, RESTContants.kRebootCPX, info.token)
    let request = RESTRequest(url: path, functionName: "", method: .POST, endcoding: .JSON)
    let params = APIParams(method: "reboot", params: [])
    request.setQueryParam(params)
    request.baseInvokerWithHeaderResponse { (result, error) in
      if result != nil {
        completion(result: result, error: nil)
      }
      else {
        completion(result: nil, error: error)
      }
    }
  }
  
  static func getWifiList(completion:(result: List<WifiInfo>?, error: RESTError?) -> Void) {
    let info = getAddressAndToken()
    let path = String(format: "http://%@%@%@", info.ip, RESTContants.kGetWifiNetworks, info.token)
    let request = RESTRequest(url: path, functionName: "", method: .POST, endcoding: .JSON)
    let params = APIParams(method: "get_scanlist", params: [])
    request.setQueryParam(params)
    request.baseInvokerWithHeaderResponse { (result, error) in
      if result != nil {
        if let result = Mapper<ScanListResponse>().map(result) {
            completion(result: result.wifis, error: nil)
        }
      }
      else {
        completion(result: nil, error: error)
      }
    }
  }
  
  static func scanWifiNetworks(completion:(result: AnyObject?, error: RESTError?) -> Void) {
    let info = getAddressAndToken()
    let path = String(format: "http://%@%@%@", info.ip, RESTContants.kGetWifiNetworks, info.token)
    let request = RESTRequest(url: path, functionName: "", method: .POST, endcoding: .JSON)
    let params = APIParams(method: "scan_wifi", params: [])
    request.setQueryParam(params)
    request.baseInvokerWithHeaderResponse { (result, error) in
      if result != nil {
        if let response = result {
          completion(result: response, error: nil)
        }
      }
      else {
        completion(result: nil, error: error)
      }
    }
  }
  
  static func configureCPX(wifiInfo wifi: WifiInfo, completion:((result: AnyObject?, error: RESTError?) -> Void)) {
    let info = getAddressAndToken()
    
    let path = String(format: "http://%@%@%@", info.ip, RESTContants.kSetCPXInfo, info.token)
    let request = RESTRequest(url: path, functionName: "", method: .POST, endcoding: .JSON)
    var paramDict = [String: String]()
    paramDict["home_ssid"] = wifi.ssid
    paramDict["mesh_ssid"] = "Home_mesh"
    paramDict["encryption"] = wifi.encryptionType
    paramDict["password"] = wifi.password
    
    let params = APIParams(method: "config", params: [paramDict])
    request.setQueryParam(params)
    request.baseInvokerWithHeaderResponse { (result, error) in
      if result != nil {
        completion(result: result, error: nil)
      }
      else {
        completion(result: nil, error: error)
      }
    }
  }

  static private func getAddressAndToken() -> (ip: String, token: String) {
    guard let ipAddress = Cache.sharedCache.getObject(forKey: UserDefaultKey.ipAddress) as? String else {
      return ("", "")
    }
    guard let token = Cache.sharedCache.getObject(forKey: UserDefaultKey.token) as? String else {
      return ("", "")
    }
    
    return (ipAddress, token)
  }
  

}
