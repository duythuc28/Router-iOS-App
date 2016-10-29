//
//  UIViewController.swift
//  RouterApp
//
//  Created by Phu Nguyen on 10/25/16.
//
//
import UIKit
import NVActivityIndicatorView

private var indicatorKey: UInt8 = 0 // We still need this boilerplate
private var loaddingViewKey: UInt8 = 0
let loadingIndicatorSize = CGSize(width: RATIO.SCREEN_WIDTH * 35, height: RATIO.SCREEN_WIDTH * 35)

extension UIViewController: NVActivityIndicatorViewable {
  
  class func instantiateFromStoryboard() -> Self {
    return instantiateFromStoryboardHelper(self, storyboardName: "Main")
  }
  
  class func instantiateFromStoryboard(storyboardName: String) -> Self {
    return instantiateFromStoryboardHelper(self, storyboardName: storyboardName)
  }
  
  private class func instantiateFromStoryboardHelper<T>(type: T.Type, storyboardName: String) -> T {
    var storyboardId = ""
    let components = "\(type.dynamicType)".componentsSeparatedByString(".")
    
    if components.count > 1 {
      storyboardId = components[0]
    }
    let storyboad = UIStoryboard(name: storyboardName, bundle: nil)
    let controller = storyboad.instantiateViewControllerWithIdentifier(storyboardId) as! T
    
    return controller
  }
  
  /**
   Display loading indicator
   */
  func startLoadingIndicator() {
    startAnimating(loadingIndicatorSize, message: "", type: .BallSpinFadeLoader , color: UIColor.whiteColor(), padding: 0, displayTimeThreshold: 0, minimumDisplayTime: 0)
  }
  /**
   Hide loading indicator
   */
  func stopLoadingIndicator() {
    stopAnimating()
  }
  
  func showAlert(withMessage message: String) {
    let alertView = UIAlertController(title: "Home Mesh", message: message, preferredStyle: .Alert)
    let okAction = UIAlertAction(title: "OK", style: .Default) { (ok) in
      self.dismissViewControllerAnimated(true, completion: nil)
    }
    alertView.addAction(okAction)
    presentViewController(alertView, animated: true, completion: nil)
  }
  
  
}