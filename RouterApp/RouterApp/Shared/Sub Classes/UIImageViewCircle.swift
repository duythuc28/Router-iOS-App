//
//  UIImageViewCircle.swift
//  ShopOnline
//
//  Created by Canh on 9/8/15.
//  Copyright (c) 2015 CanhTran. All rights reserved.
//

import UIKit

class UIImageViewCircle: UIImageView  {
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
    // Drawing code
    }
    */
    override func awakeFromNib() {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.layer.masksToBounds = false
        self.clipsToBounds = true
    }
    
}