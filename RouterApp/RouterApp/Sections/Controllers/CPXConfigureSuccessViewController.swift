//
//  CPXConfigureSuccessViewController.swift
//  RouterApp
//
//  Created by iOS Developer on 10/28/16.
//
//

import UIKit

class CPXConfigureSuccessViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.setNavigationBarHidden(true, animated: false)
  }
  
  @IBAction func finishConfig(sender: AnyObject) {
    self.navigationController?.popToRootViewControllerAnimated(true)
  }
  
}
