//
//  UserAPI.swift
//  Swift_Core
//
//  Created by Canh on 1/5/16.
//  Copyright © 2016 iOS_Dev16. All rights reserved.
//

import Foundation
import SwiftyJSON

class RESTContants: NSObject {
    
    //MARK: RESTRequest Header Keys
    static let kDefineRESTRequestHeaderKey              = "Header"
    static let kDefineRESTRequestAuthorizationKey       = "Authorization"
    static let kDefineRESTRequestContentTypeKey         = "Content-Type"
    static let kDefineRESTRequestAcceptKey              = "Accept"
    
    //MARK: Keys for parser
    static let kDefineSuccessKeyFromResponseData        = "status"
    static let kDefineMessageKeyFromResponseData        = "error"
    static let kDefineDefaultMessageKeyFromResponseData = "unknow_error"
    
    //MARK: Prepairing request
    static let kDefineRequestTimeOut                    = 300.0
    static let kDefineStatusCodeSuccess                 = 200
    
    //MARK: Webservice url
    
    // Production
    //static let kDefineWebserviceUrl                     = "http://experfi.com/experfi_api/Api/"
    static let kDefineWebserviceUrl                     = "http://experfi.com/experfi_api/ios/Api/"
    // Dev
    static let kDefineWebImageURL                       = "http://experfi.com/experfi_api/images/"
    
    static let kDefineWebserviceResourceUrl             = ""

    static let headers = [ "Content-Type" : "application/json"]
    
}

extension RESTRequest {
    
    static func checkSuccessFromResponseData(responseData: NSData?) -> Bool {
        if(responseData?.length == 0) {
            return false
        }
        
        let jsonObj: JSON = JSON(data: responseData!)
        if(jsonObj != nil)
        {
            let isSuccess: Bool = jsonObj[RESTContants.kDefineSuccessKeyFromResponseData].boolValue
            
            return isSuccess
        }
        
        
        return false
    }
}

enum RESTRequestBodyType {
    case JSON
    case Form
}