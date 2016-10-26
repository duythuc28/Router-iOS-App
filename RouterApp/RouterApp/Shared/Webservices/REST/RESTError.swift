//
//  RESTError.swift
//  9Gags
//
//  Created by iOs_Dev on 1/8/16.
//  Copyright © 2016 Duong Tran. All rights reserved.
//

import Foundation
import SwiftyJSON
import ObjectMapper
import Alamofire

class RESTError: RESTResponse {
  
  convenience required init?(_ map: Map) {
    self.init()
  }
  
  static func parseError(response: Response<AnyObject, NSError>) -> RESTError {
    let restError = (response.result.value != nil ? Mapper<RESTError>().map(response.result.value) : RESTError())
    let error = response.result.error
    
    if error != nil {
      restError?.message = (error?.localizedDescription)!
      restError?.statusCode = (error?.code)!
    }
    
    return restError!
  }
  
}
