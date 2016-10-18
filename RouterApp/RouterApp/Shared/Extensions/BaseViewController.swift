////
////  BaseViewController.swift
////  Experfi
////
////  Created by Canh Tran on 6/26/16.
////  Copyright © 2016 Canh Tran. All rights reserved.
////
//
//import UIKit
//
//class BaseViewController: UIViewController {
//    
//    private var _panGesture: UIPanGestureRecognizer!
//    private var _scrollState: String!
//    private var _gestureIsActive = false
//    private var _lastContentOffsetY: CGFloat = 0.0
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        bindNavigationScrolling()
//    }
//    
//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//        
//    }
//}
//
//
//extension BaseViewController: NavigationScrollProvider {
//    
//    var panGesture: UIPanGestureRecognizer {
//        get { return _panGesture }
//        set { _panGesture = newValue }
//    }
//    
//    var scrollState: String {
//        get { return _scrollState }
//        set { _scrollState = newValue }
//    }
//    
//    var gestureIsActive: Bool {
//        get { return _gestureIsActive }
//        set { _gestureIsActive = newValue }
//    }
//    
//    var lastContentOffsetY: CGFloat {
//        get { return _lastContentOffsetY }
//        set { _lastContentOffsetY = newValue }
//    }
//    
//    func navigationScrollingView() -> UIScrollView? {
//        return nil
//    }
//    
//}
//
