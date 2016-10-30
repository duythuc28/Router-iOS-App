//
//  CPXDetailOptimizeViewController.swift
//  RouterApp
//
//  Created by Phu Nguyen on 10/26/16.
//
//

import UIKit

class CPXDetailOptimizeViewController: UIViewController {
  @IBOutlet weak var optimizingView: UIView!
  
  @IBOutlet weak var cpxInfoView: UIView!
  @IBOutlet weak var optimizeButton: UIButton!
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Optimize Quality"
  }

  @IBAction func optimizeCPX(sender: AnyObject) {
    self.startAnimating()
    optimizingView.hidden = false
    cpxInfoView.hidden = true
    optimizeButton.hidden = true
    APIManager.rebootCPX { (result, error) in
      self.stopAnimating()
      self.cpxInfoView.hidden = false
      self.optimizeButton.hidden = false
      self.optimizingView.hidden = true
      if result != nil {
        self.showAlert(withMessage: "Optimize successfully")
      }
      else {
        self.showAlert(withMessage: "Have something wrong, please try again!")
      }
    }
  }
}
