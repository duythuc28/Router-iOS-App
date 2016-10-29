//
//  APIManager.swift
//  RouterApp
//
//  Created by Phu Nguyen on 10/26/16.
//
//

import Foundation
import Alamofire

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
    guard let ipAddress = Cache.sharedCache.getObject(forKey: UserDefaultKey.ipAddress) as? String else {
      return
    }
    guard let token = Cache.sharedCache.getObject(forKey: UserDefaultKey.token) as? String else {
      return
    }
    
    let path = String(format: "http://%@%@%@", ipAddress, RESTContants.kSetCPXInfo, token)
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
    guard let ipAddress = Cache.sharedCache.getObject(forKey: UserDefaultKey.ipAddress) as? String else {
      return
    }
    guard let token = Cache.sharedCache.getObject(forKey: UserDefaultKey.token) as? String else {
      return
    }
    
    let path = String(format: "http://%@%@%@", ipAddress, RESTContants.kRebootCPX, token)
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
  

}
