//
//  UserAPI.swift
//  Swift_Core
//
//  Created by Canh on 1/5/16.
//  Copyright © 2016 iOS_Dev16. All rights reserved.
//

import Foundation
import SwiftyJSON

class RESTMultipart: NSObject {
    
    var name: String! = ""
    var contentType: String! = ""
    var data: NSData!
    
    init(name: String!, contentType: String!, data: NSData!) {
        self.name = name
        self.contentType = contentType
        self.data = data
    }
    
    func getHeader() -> NSMutableDictionary {
        let header = NSMutableDictionary()
        
        header.setValue("form-data; name=" + self.name, forKey: "Content-Disposition")
        header.setValue(self.contentType, forKey: "Content-Type")
        
        return header
    }
    
    class JSONPart: RESTMultipart {
        init(name: String!, jsonObject: NSObject) {
            let data: NSData! = NSKeyedArchiver.archivedDataWithRootObject(JSON.init(jsonObject).dictionaryObject!)
            
            super.init(name: name, contentType: "application/json; charset=UTF-8", data: data)
        }
    }
    
    class FilePart: RESTMultipart {
        
        var fileName: String!
        
        init(name: String!, fileName: String!, data: NSData!) {
            super.init(name: name, contentType: "application/octet-stream", data: data)
            self.fileName = fileName
        }
        
        override func getHeader() -> NSMutableDictionary {
            let header = super.getHeader()
            header.setValue("form-data; name=" + self.name + ";" +
                "filename=" + self.fileName, forKey: "Content-Disposition")
            
            return header
        }
    }
}