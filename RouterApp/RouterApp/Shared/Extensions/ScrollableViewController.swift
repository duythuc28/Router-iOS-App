//
//  ScrollableViewController.swift
//  Experfi
//
//  Created by Canh Tran on 6/26/16.
//  Copyright © 2016 Canh Tran. All rights reserved.
//

import UIKit

let NearZero: CGFloat = 0.000001

public enum NavigationScrollProviderScrollState: String {
    case None = "NONE"
    case ScrollingUp = "SCROLLING_UP"
    case ScrollingDown = "SCROLLING_DOWN"
}

@objc public protocol NavigationScrollProvider {
    var panGesture: UIPanGestureRecognizer { get set }
    var scrollState: String { get set }
    var gestureIsActive: Bool { get set }
    var lastContentOffsetY: CGFloat { get set }
    
    func navigationScrollingView() -> UIScrollView?
    func adjustScrollingViewInsets()
}

//extension UIViewController: UIGestureRecognizerDelegate {
//    
//    
//    /// If this UIViewController instance implements the NavigationScrollProvider protocol, binds
//    /// scrolling of the provided navigation scrolling view to the hiding / showing of the navigation
//    /// bar.
//    ///
//    /// If this instance does not implement the NavigationScrollProvider protocol, or is not
//    /// contained in a UINavigationController, this method is a noop.
//    public func bindNavigationScrolling() {
//        
//        guard let scrollProvider = self as? NavigationScrollProvider else {
//            return
//        }
//        if navigationController == nil {
//            return
//        }
//        
//        // here we know this UIViewController instance implements NavigationScrollProvider
//        // and is contained in a UINavigationController
//        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(UIViewController.handlePan(_:)))
//        panGesture.delegate = self
//        scrollProvider.panGesture = panGesture
//        
//        // bind to notifications
//        bindNotifications()
//        
//        // clean the panGesture and add it to the newly set scrollView
//        scrollProvider.navigationScrollingView()?.addGestureRecognizer(panGesture)
//    }
//    
//    
//    /// If this UIViewController instance implements the NavigationScrollProvider protocol and is
//    /// contained within a UINavigationController, will reset the UINavigationBar position.
//    public func resetNavBarPosition(animated:Bool = true) {
//        if navigationController == nil {
//            return
//        }
//        
//        if let scrollProvider = self as? NavigationScrollProvider {
//            navigationController!.navigationBar.scroll_nav_resetToDefaultPosition(animated, scrollProvider: scrollProvider)
//        }
//        
//    }
//    
//    // MARK: - Pan Gesture Handling
//    
//    public func handlePan(gesture: UIPanGestureRecognizer) {
//        guard let scrollProvider = selfAsScrollProvider() else {
//            return
//        }
//        guard let myScrollView = scrollProvider.navigationScrollingView() else{
//            return
//        }
//        
//        // return if the gesture is not attached to our scroll view
//        if gesture.view !== myScrollView {
//            return
//        }
//        
//        if myScrollView.frame.size.height + (navigationController!.navigationBar.bounds.size.height * 2) >= myScrollView.contentSize.height {
//            return
//        }
//        
//        let contentOffsetY = myScrollView.contentOffset.y
//        
//        // Do nothing if we are scrolling the contentInset (padding)
//        if contentOffsetY < -myScrollView.contentInset.top {
//            return
//        }
//        
//        // if the gesture just started...reset the state and store the last offset
//        if gesture.state == .Began {
//            scrollProvider.scrollState = NavigationScrollProviderScrollState.None.rawValue
//            scrollProvider.lastContentOffsetY = contentOffsetY
//            scrollProvider.gestureIsActive = true
//            return
//        }
//        
//        let deltaY = contentOffsetY - scrollProvider.lastContentOffsetY
//        if deltaY < 0.0 {
//            scrollProvider.scrollState = NavigationScrollProviderScrollState.ScrollingDown.rawValue
//        } else if deltaY > 0.0 {
//            scrollProvider.scrollState = NavigationScrollProviderScrollState.ScrollingUp.rawValue
//        }
//        
//        var newFrame = navigationController!.navigationBar.frame
//        var alpha: CGFloat = 1.0
//        let statusBarHeight = navigationController!.navigationBar.scroll_nav_statusBarHeight()
//        let maxY = statusBarHeight
//        let minY = maxY - CGRectGetHeight(newFrame) + 1.0
//        
//        let isScrolling = scrollProvider.scrollState == NavigationScrollProviderScrollState.ScrollingUp.rawValue || scrollProvider.scrollState == NavigationScrollProviderScrollState.ScrollingDown.rawValue
//        scrollProvider.gestureIsActive = gesture.state != .Ended && gesture.state != .Cancelled
//        
//        if isScrolling && !scrollProvider.gestureIsActive {
//            var contentOffsetYDelta: CGFloat = 0.0
//            if scrollProvider.scrollState == NavigationScrollProviderScrollState.ScrollingDown.rawValue {
//                contentOffsetYDelta = maxY - newFrame.origin.y
//                newFrame.origin.y = maxY
//                alpha = 1.0
//            }
//            else if scrollProvider.scrollState == NavigationScrollProviderScrollState.ScrollingUp.rawValue {
//                contentOffsetYDelta = minY - newFrame.origin.y
//                newFrame.origin.y = minY
//                alpha = NearZero
//            }
//            
//            navigationController!.navigationBar.scroll_nav_setFrame(newFrame, alpha: alpha, animated: true, scrollProvider: scrollProvider)
//            
//            if !myScrollView.decelerating {
//                let newContentOffset = CGPointMake(myScrollView.contentOffset.x, contentOffsetY - contentOffsetYDelta)
//                myScrollView.setContentOffset(newContentOffset, animated: true)
//            }
//            
//        } else {
//            newFrame.origin.y -= deltaY;
//            newFrame.origin.y = min(maxY, max(newFrame.origin.y, minY))
//            
//            alpha = (newFrame.origin.y - (minY + statusBarHeight)) / (maxY - (minY + statusBarHeight))
//            alpha = max(NearZero, alpha);
//            
//            navigationController!.navigationBar.scroll_nav_setFrame(newFrame, alpha: alpha, animated: false, scrollProvider: scrollProvider)
//        }
//        
//        scrollProvider.lastContentOffsetY = contentOffsetY
//    }
//    
//    // MARK: - NavigationScrollProvider
//    
//    public func adjustScrollingViewInsets() {
//        guard let scrollProvider = selfAsScrollProvider() else {
//            return
//        }
//        guard let scrollView = scrollProvider.navigationScrollingView() else {
//            return
//        }
//        
//        if scrollView.contentInset.top == 0 && scrollView.contentOffset.y == 0 {
//            return
//        }
//        
//        var insets = scrollView.contentInset
//        insets.top = 0.0//navigationController!.navigationBar.frame.origin.y //+ navigationController!.navigationBar.frame.size.height
//        scrollView.contentInset = insets
//        
//        let isAtTop = !scrollProvider.gestureIsActive && scrollView.contentOffset.y <= 0
//        if isAtTop && scrollView.contentOffset.y != scrollView.contentInset.top {
//            let newContentOffset = CGPointMake(scrollView.contentOffset.x, -scrollView.contentInset.top)
//            scrollView.setContentOffset(newContentOffset, animated: false)
//        }
//    }
//    
//    // MARK: - UIGestureRecognizerDelegate
//    
//    public func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        return true
//    }
//    
//    // MARK: - Notifications
//    
//    private func bindNotifications() {
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(UIViewController.statusBarOrientationDidChange), name: UIApplicationDidChangeStatusBarOrientationNotification, object: nil)
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(UIViewController.applicationDidBecomeActive), name: UIApplicationDidBecomeActiveNotification, object: nil)
//    }
//    
//    private func unbindNotifications() {
//        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIApplicationDidChangeStatusBarOrientationNotification, object: nil)
//        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIApplicationDidBecomeActiveNotification, object: nil)
//    }
//    
//    public func statusBarOrientationDidChange() {
//        guard let scrollProvider = selfAsScrollProvider() else {
//            return
//        }
//        guard let navControl = navigationController else {
//            return
//        }
//        scrollProvider.scrollState = NavigationScrollProviderScrollState.None.rawValue
//        navControl.navigationBar.scroll_nav_resetToDefaultPosition(false, scrollProvider: scrollProvider)
//    }
//    
//    public func applicationDidBecomeActive() {
//        guard let scrollProvider = selfAsScrollProvider() else {
//            return
//        }
//        guard let navControl = navigationController else {
//            return
//        }
//        scrollProvider.scrollState = NavigationScrollProviderScrollState.None.rawValue
//        navControl.navigationBar.scroll_nav_resetToDefaultPosition(false, scrollProvider: scrollProvider)
//    }
//    
//    // MARK: - Helpers
//    
//    /**
//     Helper for getting self as a NavigationScrollProvider. This will crash if its called
//     by a non-conformer. Should only be called from bindNavigationScrolling() which ensures
//     this cast will succeed.
//     */
//    private func selfAsScrollProvider() -> NavigationScrollProvider? {
//        return self as? NavigationScrollProvider
//    }
//    
//}