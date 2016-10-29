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
    self.locationTextField.delegate = self
  }

  @IBAction func addNewLocation(sender: AnyObject) {
    view.endEditing(true)
    if locationTextField.hasText() && didAddLocation != nil {
        didAddLocation!(name: locationTextField.text!)
    }
    self.navigationController?.popViewControllerAnimated(true)
  }
  
  override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
    view.endEditing(true)
  }

}
extension CPXDetailAddNewLocationViewController: UITextFieldDelegate {
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
