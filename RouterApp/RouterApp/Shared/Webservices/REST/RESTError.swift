//
//  UserAPI.swift
//  Swift_Core
//
//  Created by Canh on 1/5/16.
//  Copyright © 2016 iOS_Dev16. All rights reserved.
//

import Foundation
import SwiftyJSON

class RESTError: NSObject {
    var errorFromResponse:  String? = ""
    var errorFromServer:    String? = ""
    override init() {
        errorFromServer = "" //set default string here
        errorFromServer = ""
    }
    
    static func parseError(responseData: NSData?, error: NSError?) -> RESTError {
        
        let restError: RESTError = RESTError.init()
        
        if (responseData != nil) {
            let jsonObj: JSON = JSON(data: responseData!)
            if(jsonObj != nil) {
                let message = jsonObj[RESTContants.kDefineMessageKeyFromResponseData].stringValue
                
                if(message.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0) {
                    restError.errorFromServer = message
                }
                else {
                    restError.errorFromServer = RESTContants.kDefineDefaultMessageKeyFromResponseData
                }
            }
            else {
                restError.errorFromServer = NSString(data: responseData!, encoding: NSUTF8StringEncoding) as String?
            }
        }
        
        if(error != nil) {
            let errorString: String! = error!.localizedDescription
            restError.errorFromResponse = errorString
        }
        
        return restError
    }
}