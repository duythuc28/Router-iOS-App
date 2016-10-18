//
//  UIButton+Custom.swift
//  ShopOnline
//
//  Created by Canh on 8/29/15.
//  Copyright (c) 2015 CanhTran. All rights reserved.
//

import UIKit

extension UIButton {
    
    func setupBorder(width:CGFloat , color:UIColor, radius:CGFloat)
    {
        self.layer.borderWidth = width
        if !color.isEqual(nil)
        {
            self.layer.borderColor = color.CGColor
        }
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    func underlineButtonTextLabel()
    {
        let titleString : NSMutableAttributedString = NSMutableAttributedString(string: self.titleLabel!.text!)
        titleString.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.StyleSingle.rawValue, range: NSMakeRange(0, self.titleLabel!.text!.characters.count))
        self.setAttributedTitle(titleString, forState: .Normal)
    }
    
    
class ButtonIconRight: UIButton {
    
    override func imageRectForContentRect(contentRect:CGRect) -> CGRect {
        var imageFrame = super.imageRectForContentRect(contentRect)
        imageFrame.origin.x = CGRectGetMaxX(super.titleRectForContentRect(contentRect)) - CGRectGetWidth(imageFrame)
        return imageFrame
    }
    
    override func titleRectForContentRect(contentRect:CGRect) -> CGRect {
        var titleFrame = super.titleRectForContentRect(contentRect)
        if (self.currentImage != nil) {
            titleFrame.origin.x = CGRectGetMinX(super.imageRectForContentRect(contentRect))
        }
        return titleFrame
    }
}
}
