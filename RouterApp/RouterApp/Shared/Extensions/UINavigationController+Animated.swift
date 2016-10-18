//
//  UINavigationController+Animated.swift
//  Experfi
//
//  Created by MC976 on 6/17/16.
//  Copyright © 2016 Canh Tran. All rights reserved.
//

import UIKit

public extension UINavigationController {
    func pushViewControllerRetro(viewController : UIViewController) {
        let transition:CATransition = CATransition()
        transition.duration = 0.4
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromTop
        self.view.layer.addAnimation(transition, forKey: kCATransition)
        self.pushViewController(viewController, animated: false)
    }
    
    func popViewControllerRetro() {
        let transition:CATransition = CATransition()
        transition.duration = 0.4
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromBottom
        self.view.layer.addAnimation(transition, forKey: kCATransition)
        self.popViewControllerAnimated(false)
    }
}