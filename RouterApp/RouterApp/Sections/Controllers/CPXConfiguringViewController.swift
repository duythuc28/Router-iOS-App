//
//  CPXConfiguringViewController.swift
//  RouterApp
//
//  Created by iOS Developer on 10/28/16.
//
//

import UIKit

class CPXConfiguringViewController: UIViewController {
  var wifiInfo: WifiInfo!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureRouter()
  }
  
  private func configureRouter() {
    APIManager.configureCPX(wifiInfo: wifiInfo) { (result, error) in
      if result != nil {
        self.performSegueWithIdentifier("showConfigureSuccess", sender: nil)
      }
      else {
        self.showAlert(withMessage: "Have something wrong, please try again!")
      }
    }
  }
  
}
