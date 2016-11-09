//
//  CPXDetailAdvancedViewController.swift
//  RouterApp
//
//  Created by Phu Nguyen on 10/26/16.
//
//

import UIKit

class CPXDetailAdvancedViewController: UITableViewController {
  
  var device: CPXDevice!
  var timer = NSTimer()
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Advanced"
  }
  
  func rebootSuccessfully() {
    self.stopAnimating()
    self.showAlert(withMessage: "Reboot successfully!", isPopRootView: true)
  }
  
  override func viewDidDisappear(animated: Bool) {
    super.viewDidDisappear(animated)
    timer.invalidate()
  }
  
  @IBAction func rebootCPX(sender: AnyObject) {
    startAnimating()
    APIManager.rebootCPX { (result, error) in
      if result != nil {
        self.timer = NSTimer.scheduledTimerWithTimeInterval(90, target: self, selector: #selector(CPXDetailAdvancedViewController.rebootSuccessfully), userInfo: nil, repeats: false)
      }
      else {
        self.stopAnimating()
        self.showAlert(withMessage: "Have something wrong, please try again!")
      }
    }
  }
  
  

}
