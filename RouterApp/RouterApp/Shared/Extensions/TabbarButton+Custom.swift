//
//  TabbarButton+Custom.swift
//  Experfi
//
//  Created by Canh Tran on 8/25/16.
//  Copyright © 2016 Canh Tran. All rights reserved.
//

import UIKit

extension UITabBarItem {
    @IBInspectable var localizeKey: String {
        get {
            return ""
        } set {
            self.title = NSLocalizedString(newValue, comment: "")
        }
    }
}
