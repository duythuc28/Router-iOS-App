//
//  UIViewController.swift
//  RouterApp
//
//  Created by Phu Nguyen on 10/25/16.
//
//
import UIKit

private var indicatorKey: UInt8 = 0 // We still need this boilerplate
private var loaddingViewKey: UInt8 = 0

extension UIViewController {
  
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
  
  var indicator: UIActivityIndicatorView {
    get {
      return associatedObject(self, key: &indicatorKey)
      {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.activityIndicatorViewStyle = .WhiteLarge
        return activityIndicator
      }
    }
    set { associateObject(self, key: &indicatorKey, value: newValue) }
  }
  
  var loadingView: UIView { //stored property
    get {
      return associatedObject(self, key: &loaddingViewKey)
      {
        let view = UIView()
        view.frame = Screen.BOUNDS
        view.backgroundColor = UIColor.blackColor()
        view.layer.opacity = 0.1
        self.indicator.center = view.center
        view.addSubview(self.indicator)
        return view
      }
    }
    set { associateObject(self, key: &loaddingViewKey, value: newValue) }
  }
  
  func associatedObject<ValueType: AnyObject>(
    base: AnyObject,
    key: UnsafePointer<UInt8>,
    initialiser: () -> ValueType)
    -> ValueType {
      if let associated = objc_getAssociatedObject(base, key)
        as? ValueType { return associated }
      let associated = initialiser()
      objc_setAssociatedObject(base, key, associated,
                               .OBJC_ASSOCIATION_RETAIN)
      return associated
  }
  func associateObject<ValueType: AnyObject>(
    base: AnyObject,
    key: UnsafePointer<UInt8>,
    value: ValueType) {
    objc_setAssociatedObject(base, key, value,
                             .OBJC_ASSOCIATION_RETAIN)
  }
  
  func showLoading() {
    if let window = UIApplication.sharedApplication().keyWindow {
      indicator.hidden = false
      indicator.startAnimating()
      window.addSubview(loadingView)
    }
  }
  
  func hideLoading() {
    indicator.stopAnimating()
    loadingView.removeFromSuperview()
  }
  
  
}