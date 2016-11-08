//
//  ConfigureForSecondCPX.swift
//  RouterApp
//
//  Created by Phu Nguyen on 11/9/16.
//
//

import UIKit

class ConfigureForSecondCPX: UIViewController {

  @IBOutlet weak var joinButton: UIButton!
  @IBOutlet weak var titleLabel: UILabel!
  var configInfo: AnyObject!
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Configure"
    if let ssid = configInfo["ssid"] as? String {
      titleLabel.text = "We have found 1 Mesh in your network: \n\n\(ssid)"
    }
  }
  
  @IBAction func joinCurrentMesh(sender: AnyObject) {
    startAnimating()
    APIManager.configureCPX(wifiInfo: configInfo, password: "", completion: { (result, error) in
      self.stopAnimating()
      if result != nil {
        self.showAlert(withMessage: "Configurate successfully", isPopRootView: true)
      }
      else {
        self.showAlert(withMessage: "Have something wrong, please try again!")
      }
    })
  }
  
  
}
