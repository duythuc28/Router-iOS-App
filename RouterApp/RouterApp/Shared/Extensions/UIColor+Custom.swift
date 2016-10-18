//
//  UIColor+Custom.swift
//  ShopOnline
//
//  Created by iOS_Dev16 on 8/31/15.
//  Copyright (c) 2015 CanhTran. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(rgb: UInt) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    static func appGreenColor () -> (UIColor) {
        return UIColor(red:0.18, green:0.60, blue:0.20, alpha:1.0)
    }
    
    static func brownishGrey () -> (UIColor) {
        return UIColor(red:0.4, green:0.4, blue:0.4, alpha:1.0)
    }
    
    static func darkishGreen () -> (UIColor) {
        return UIColor(red:44/255, green:153/255, blue:52/255, alpha:1.0)
    }
    
    static func darkishPink () -> (UIColor) {
        return UIColor(red:218/255, green:70/255, blue:109/255, alpha:1.0)
    }
}