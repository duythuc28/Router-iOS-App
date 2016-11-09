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
  
  @IBOutlet weak var qualityLabel: UILabel!
  @IBOutlet weak var numberClientLabel: UILabel!
  
  var device: CPXDevice!
  var timer = NSTimer()
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Optimize Quality"
    qualityLabel.text = "Quality: \(device.quality)"
    numberClientLabel.text = "Clients: \(device.clients.count)"
  }
  
  func getCPXInfo() {
    self.stopAnimating()
    self.cpxInfoView.hidden = false
    self.optimizeButton.hidden = false
    self.optimizingView.hidden = true
    self.showAlert(withMessage: "Optimize successfully", isPopRootView: true)
  }

  @IBAction func optimizeCPX(sender: AnyObject) {
    self.startAnimating()
    optimizingView.hidden = false
    cpxInfoView.hidden = true
    optimizeButton.hidden = true
    APIManager.optimizeCPX { (result, error) in
      if result != nil {
        self.timer = NSTimer.scheduledTimerWithTimeInterval(90, target: self, selector: #selector(CPXDetailOptimizeViewController.getCPXInfo), userInfo: nil, repeats: false)
      }
      else {
        self.stopAnimating()
        self.cpxInfoView.hidden = false
        self.optimizeButton.hidden = false
        self.optimizingView.hidden = true
        self.showAlert(withMessage: "Have something wrong, please try again!")
      }
    }
  }
}
