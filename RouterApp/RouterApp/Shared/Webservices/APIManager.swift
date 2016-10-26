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
//    Alamofire.request(.POST, path, parameters: ["method":"get_info", "params":[]], encoding: .JSON, headers: ["Content-Type" : "application/json"]).responseJSON { (response) -> Void in
//      print(response)
//    }
    let request = RESTRequest(url: path, functionName: "", method: .POST, endcoding: .JSON)
    let params = APIParams(method: "get_info", params: [])
    request.setQueryParam(params)
    request.baseInvoker { (result, error) in
      if result != nil {
        print(result)
      }
    }
  }

}
