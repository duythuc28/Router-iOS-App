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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Advanced"
  }
  
  @IBAction func rebootCPX(sender: AnyObject) {
    APIManager.rebootCPX { (result, error) in
      if result != nil {
        self.showAlert(withMessage: "Reboot successfully!", isPopRootView: true)
        /*
         error = "<null>";
         id = "<null>";
         result = 0;
         */
        
      }
      else {
        self.showAlert(withMessage: "Have something wrong, please try again!")
      }
    }
  }
  
  

}
