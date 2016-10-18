//
//  UIAlertController+Custom.swift
//  Experfi
//
//  Created by MC976 on 4/13/16.
//  Copyright © 2016 Canh Tran. All rights reserved.
//

import UIKit

public extension UIAlertController {
    class func showAlertView(title:String , message:String, viewController : UIViewController)
    {
        let alert = UIAlertController(title: title, message:message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
        viewController.presentViewController(alert, animated: true){}
    }
    
    class func showConnectionAlertView() -> UIAlertController
    {
        let alert = UIAlertController(title: "No connection", message: "Please turn on your Wifi/3G.", preferredStyle: .Alert)
//        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel) { _ in })
//        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action) in
//            let url = NSURL(string: "prefs:root=WIFI")
//            UIApplication.sharedApplication().openURL(url!)
//        }))
        alert.addAction(UIAlertAction(title: "Ok", style: .Cancel) { _ in })
        return alert
        
    }
}
