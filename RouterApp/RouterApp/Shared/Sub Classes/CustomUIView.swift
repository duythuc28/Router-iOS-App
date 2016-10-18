//
//  CustomUIView.swift
//  ShopOnline
//
//  Created by Canh on 9/6/15.
//  Copyright (c) 2015 CanhTran. All rights reserved.
//

import UIKit

@IBDesignable

class CustomUIView: UIView {

        @IBInspectable var borderColor: UIColor = UIColor.clearColor() {
            didSet {
                layer.borderColor = borderColor.CGColor
            }
        }
        
        @IBInspectable var borderWidth: CGFloat = 0 {
            didSet {
                layer.borderWidth = borderWidth
            }
        }
        
        @IBInspectable var cornerRadius: CGFloat = 0 {
            didSet {
                layer.cornerRadius = cornerRadius * WIDTH / 320
            }
        }

}
