//
//  UIImageView+Custom.swift
//  ShopOnline
//
//  Created by Canh on 8/22/15.
//  Copyright (c) 2015 CanhTran. All rights reserved.
//

import UIKit

public extension UIImageView {
    
    func setupBorderImageView()
    {
        self.layer.borderWidth = 1.0
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.size.width/2
        self.clipsToBounds = true
    }
}