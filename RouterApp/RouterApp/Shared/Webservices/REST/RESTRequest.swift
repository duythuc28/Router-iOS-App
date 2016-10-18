//
//  UserAPI.swift
//  Swift_Core
//
//  Created by Canh on 1/5/16.
//  Copyright © 2016 iOS_Dev16. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import ObjectMapper

typealias RestAPICompletion = (result: AnyObject?, error: RESTError?) -> Void
typealias RestDownloadProgress = (bytesRead : Int64, totalBytesRead : Int64, totalBytesExpectedToRead : Int64) -> Void


class RESTRequest: NSObject
{
    var baseUrl: String = ""
    var parameters: [String: AnyObject] = [:]
    var headers: [String: String] = RESTContants.headers
    var multiparts: [RESTMultipart] = []
    var requestBodyType: RESTRequestBodyType
    var requestMethod : Alamofire.Method
    var endcoding: ParameterEncoding

    //MARK: Base
    init(subPath: String, functionName: String, method : RESTEnum.RequestMethod, endcoding: RESTEnum.Endcoding) {
        
        //set base url
        baseUrl = RESTContants.kDefineWebserviceUrl + subPath + (functionName.characters.count == 0 ? "" : ("/" + functionName))
        requestBodyType = RESTRequestBodyType.JSON
        
        switch endcoding
        {
        case .JSON:
            self.endcoding = ParameterEncoding.JSON
            break
        case .URL:
            self.endcoding = ParameterEncoding.URL
            break
        case .CUSTOM:
            self.endcoding = ParameterEncoding.URLEncodedInURL
            break
        }
        
        switch method
        {
        case .GET:
            requestMethod = Alamofire.Method.GET
            break
        case .POST:
            requestMethod = Alamofire.Method.POST
            break
        case .PUT:
            requestMethod = Alamofire.Method.PUT
            break
        case .DELETE:
            requestMethod = Alamofire.Method.DELETE
            break
        default:
            requestMethod = Alamofire.Method.GET
            break
        }
    }
    
    
    //MARK: Properties
    
    func addQueryParam(objectParam: NSObject)
    {
        let json : [String : AnyObject] = objectParam.JSONDictionary()//ObjectMapper.sharedInstance().dictionaryFromObject(objectParam)
        parameters = json
    }
    
    func addQueryParam(name: String, value: AnyObject)
    {
        parameters[name] = value.description as String
    }
    
    func addHeader(name: String, value: AnyObject)
    {
        headers[name] = value as? String
    }
    
    func setContentType(contentType: String)
    {
        headers[RESTContants.kDefineRESTRequestContentTypeKey] = contentType
    }
    
    func setAccept(accept: String)
    {
        headers[RESTContants.kDefineRESTRequestAcceptKey] = accept
    }
    
    func setAuthorization(authorization: String)
    {
        headers[RESTContants.kDefineRESTRequestAuthorizationKey] = authorization
    }
    
    //MARK: Alamofire functions
  
    func baseInvoker(completion: RestAPICompletion)
    { 
        Alamofire.Manager.sharedInstance.request(self.requestMethod, self.baseUrl, parameters: parameters, encoding: self.endcoding).responseJSON { (response) -> Void in
            if self.parseDataSuccess(response) {
                completion(result: response.result.value, error: nil)
            }
            else {
                let restError = RESTError.parseError(response.data, error: nil)
                completion(result: nil, error: restError)
            }
        }
    }
    
    func parseDataSuccess(result : Response<AnyObject, NSError>) -> Bool {
        var isSuccess = false
        if result.response?.statusCode != RESTContants.kDefineStatusCodeSuccess
        {
            return false
        }
        let jsonObj: JSON = JSON(data: result.data!)
        if(jsonObj != nil)
        {
            let message = jsonObj[RESTContants.kDefineMessageKeyFromResponseData].stringValue
            
            if(message.characters.count > 0 || message.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0)
            {
                isSuccess = false
            }
            else
            {
                isSuccess = true
            }
        }
        
        return isSuccess
    }
    
    
    /*----------------------------*/
    
    let destination : (NSURL, NSHTTPURLResponse) -> (NSURL) = {
        (temporaryURL, response) in
        
        if let directoryURL : NSURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]  {
            var localImageURL = directoryURL.URLByAppendingPathComponent("\("myPatch").\(response.suggestedFilename!)")
            return localImageURL
        }
        return temporaryURL
    }
    
    func baseDownload(progressDownloading : RestDownloadProgress, completion: RestAPICompletion)
    {
        Alamofire.download(.GET, "http://www.planwallpaper.com/static/images/city-under-construction-1080p-full-hd-wallpaper.jpg"/*self.baseUrl*/, parameters: self.parameters, encoding: .JSON, headers: self.headers, destination: destination)
            .progress { bytesRead, totalBytesRead, totalBytesExpectedToRead in
                print(totalBytesRead)
                
                // This closure is NOT called on the main queue for performance
                // reasons. To update your ui, dispatch to the main queue.
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
    
    
}