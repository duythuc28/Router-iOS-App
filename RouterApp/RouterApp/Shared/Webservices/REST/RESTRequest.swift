//
//  RESTRequest.swift
//  9Gags
//
//  Created by iOs_Dev on 1/8/16.
//  Copyright © 2016 toan.quach. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import ObjectMapper

typealias RestAPICompletion = (result: AnyObject?, error: RESTError?) -> Void
typealias RestDownloadProgress = (bytesRead: Int64, totalBytesRead: Int64, totalBytesExpectedToRead: Int64) -> Void

class RESTRequest: NSObject {

  var baseUrl: String = ""
  var parameters: [String: AnyObject] = [:]
  var headers: [String: String] = RESTContants.Headers
  var multiparts = NSMutableArray()
  var requestMethod: Alamofire.Method = .GET
  var endcoding: ParameterEncoding = .URL
  //MARK: Base
  init(url: String, functionName: String, method: Alamofire.Method, endcoding: ParameterEncoding) {
    super.init()
    self.handleInit(url + functionName, method: method, endcoding: endcoding)
  }

  init(functionName: String, method: Alamofire.Method, endcoding: ParameterEncoding) {
    super.init()
    self.handleInit(RESTContants.WebserviceUrl + functionName, method: method, endcoding: endcoding)
  }

  func handleInit(baseUrl: String, method: Alamofire.Method, endcoding: ParameterEncoding) {
    self.baseUrl = baseUrl
    self.endcoding = endcoding
    self.requestMethod = method

//    if let accountToken = DLCache.sharedCache.getObject(forKey: UserDefault.AccountToken) {
//      self.addHeader(RESTContants.RequestAuthorizationKey, value: RESTContants.PrefixToken + String(accountToken))
//    }
  }

  //MARK: Properties
  func setQueryParam(param: RESTParam) {
    parameters = param.toDictionary()
  }

  func addQueryParam(name: String, value: AnyObject?) {
    if let dataValue = value as? NSData {
      parameters[name] = dataValue
    } else {
      parameters[name] = value as? String
    }
  }

  func addHeader(name: String, value: AnyObject?) {
    headers[name] = value as? String
  }

  func setContentType(contentType: String) {
    headers[RESTContants.RequestContentTypeKey] = contentType
  }

  func setAccept(accept: String) {
    headers[RESTContants.RequestAcceptKey] = accept
  }

  func setAuthorization(authorization: String) {
    headers[RESTContants.RequestAuthorizationKey] = authorization
  }

  func addPartJson(name: String, model: NSObject) {
    let part = RESTMultipart.JSONPart(name: name, jsonObject: model)
    self.multiparts.addObject(part)
  }

  func addPartFile(name: String, fileName: String, data: NSData) {
    let part = RESTMultipart.FilePart(name: name, fileName: fileName, data: data)
    self.multiparts.addObject(part)
  }

  //MARK: Alamofire functions
  func baseInvoker(completion: RestAPICompletion) {
    DLRequestManager.sharedManager.getManager().request(self.requestMethod, self.baseUrl, parameters: self.parameters, encoding: self.endcoding, headers: self.headers).responseJSON { (response) -> Void in
      self.handleResponse(response, completion: completion)
    }
  }
  
  func baseInvokerWithHeaderResponse(completion: RestAPICompletion) {
    DLRequestManager.sharedManager.getManager().request(self.requestMethod, self.baseUrl, parameters: self.parameters, encoding: self.endcoding, headers: self.headers).responseJSON { (response) -> Void in
      self.handleHeaderResponse(response, completion: completion)
    }
  }
  
  func headInvoker(completion:(statusCode: Int) -> Void) {
    DLRequestManager.sharedManager.getManager().request(self.requestMethod, self.baseUrl, parameters: self.parameters, encoding: self.endcoding, headers: self.headers).responseJSON { (response) -> Void in
      if let response = response.response {
        completion(statusCode: response.statusCode)
      }
    }
  }

  func baseUpload(completion: RestAPICompletion) {
    DLRequestManager.sharedManager.getManager().upload(self.requestMethod, self.baseUrl, headers: self.headers, multipartFormData: { multipartFormData in
      for (key, value) in self.parameters {
        if let dataValue = value as? NSData {
          multipartFormData.appendBodyPart(data: dataValue, name: key, fileName: "avatar.\(self.imageType(dataValue))", mimeType: "image/\(self.imageType(dataValue))")
        } else {
          let stringValue = String(value)
          multipartFormData.appendBodyPart(data: stringValue.dataUsingEncoding(NSUTF8StringEncoding)!, name: key)
        }
      }
      }, encodingMemoryThreshold: Manager.MultipartFormDataEncodingMemoryThreshold,
         encodingCompletion: { encodingResult in
          switch encodingResult {
          case .Success(let result, _, _):
            result.responseJSON(completionHandler: { response in
              self.handleResponse(response, completion: completion)
            })
          case .Failure(let encodingError):
            print(encodingError)
          }
    })
  }

  func handleResponse(response: Response<AnyObject, NSError>, completion: RestAPICompletion) {
    let restReponse = Mapper<RESTResponse>().map(response.result.value)
    if restReponse?.statusCode == RESTContants.StatusCodeSuccess {
      completion(result: response.result.value, error: nil)
    } else {
      completion(result: nil, error: RESTError.parseError(response))
    }
  }
  
  func handleHeaderResponse(response: Response<AnyObject, NSError>, completion: RestAPICompletion) {
    completion(result: response.result.value, error: RESTError.parseError(response))
//    if restReponse?.statusCode == RESTContants.StatusCodeSuccess {
//      completion(result: response.result.value, error: nil)
//    } else {
//      completion(result: nil, error: RESTError.parseError(response))
//    }
  }

  func imageType(imgData: NSData) -> String {
    var c = [UInt8](count: 1, repeatedValue: 0)
    imgData.getBytes(&c, length: 1)

    let ext: String

    switch (c[0]) {
    case 0xFF: ext = "jpg"

    case 0x89: ext = "png"

    case 0x47: ext = "gif"

    case 0x49, 0x4D : ext = "tiff"

    default: ext = "jpg" //unknown
    }

    return ext
  }

  /*----------------------------*/
  let destination: (NSURL, NSHTTPURLResponse) -> (NSURL) = {
    (temporaryURL, response) in

    if let directoryURL: NSURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0] {
      var localImageURL = directoryURL.URLByAppendingPathComponent("\("myPatch").\(response.suggestedFilename!)")
      return localImageURL
    }

    return temporaryURL
  }

  func baseDownload(progressDownloading: RestDownloadProgress, completion: RestAPICompletion) {
    Alamofire.download(.GET, "http://www.planwallpaper.com/static/images/city-under-construction-1080p-full-hd-wallpaper.jpg"/*self.baseUrl*/, parameters: self.parameters, encoding: .JSON, headers: self.headers, destination: destination)
      .progress { bytesRead, totalBytesRead, totalBytesExpectedToRead in
        dispatch_async(dispatch_get_main_queue()) {
          //print("Total bytes read on main queue: \(totalBytesRead)")
          progressDownloading(bytesRead: bytesRead, totalBytesRead: totalBytesRead, totalBytesExpectedToRead: totalBytesExpectedToRead)
        }
      }
      .response { _, _, _, error in
        if let error = error {
          print("Failed with error: \(error)")
        } else {
          print("Downloaded file successfully")
        }
    }
  }

  func downloadFile(fromURLString string: String, completion: (path: String?) -> Void) {
    let destination = Alamofire.Request.suggestedDownloadDestination(directory: .DocumentDirectory, domain: .UserDomainMask)
    Alamofire.download(.GET, string, destination: destination)
      .response { (request: NSURLRequest?, response: NSHTTPURLResponse?, data: NSData?, error: NSError?) in
        if error == nil {
          let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
          let url = NSURL(fileURLWithPath: path)
          let filePath = url.URLByAppendingPathComponent((response?.suggestedFilename)!).path!
          completion(path: filePath)
        }
        else {
          if let path = error?.userInfo["NSDestinationFilePath"] as? String {
            completion(path: path)
          }
          else {
            completion(path: "")
          }
        }

    }
  }

}


class DLRequestManager: Alamofire.Manager {
  static let sharedManager = DLRequestManager()
  private var manager: Alamofire.Manager?
  
  init() {
    super.init()
  }
  
  func getManager() -> Alamofire.Manager {
    if let mger = manager {
      return mger
    }
    var policies: [String:ServerTrustPolicy]!
    #if DEV
      policies = [ RESTContants.HostName : .DisableEvaluation ]
      //      policies = [
      //        RESTContants.HostName: .PinCertificates(
      //          certificates: ServerTrustPolicy.certificatesInBundle(),
      //          validateCertificateChain: true,
      //          validateHost: true
      //        )
      //      ]
    #else
      policies = [
        RESTContants.HostName: .PinCertificates(
          certificates: ServerTrustPolicy.certificatesInBundle(),
          validateCertificateChain: true,
          validateHost: true
        )
      ]
      //      policies = [ RESTContants.HostName : .DisableEvaluation ]
    #endif
    let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
    configuration.HTTPAdditionalHeaders = Alamofire.Manager.defaultHTTPHeaders
    self.manager = Alamofire.Manager(configuration: configuration, serverTrustPolicyManager: ServerTrustPolicyManager(policies: policies))
    return self.manager!
  }
  
}

