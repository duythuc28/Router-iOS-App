//
//  CPXDetailAddNewLocationViewController.swift
//  RouterApp
//
//  Created by Phu Nguyen on 10/25/16.
//
//

import UIKit

class CPXDetailAddNewLocationViewController: UIViewController {
  @IBOutlet weak var locationTextField: UITextField!
  
  var didAddLocation:((name: String) -> Void)?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Custom Location"
  }

  @IBAction func addNewLocation(sender: AnyObject) {
    if locationTextField.hasText() && didAddLocation != nil {
        didAddLocation!(name: locationTextField.text!)
    }
    self.navigationController?.popViewControllerAnimated(true)
  }
}
