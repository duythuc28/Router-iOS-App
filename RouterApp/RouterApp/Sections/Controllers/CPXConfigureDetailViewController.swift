//
//  CPXConfigureDetailViewController.swift
//  RouterApp
//
//  Created by iOS Developer on 10/28/16.
//
//

import UIKit

class CPXConfigureDetailViewController: UIViewController {

    @IBOutlet weak var mPasswordTextField: UITextField!
    @IBOutlet weak var mPasswordLabel: UILabel!
    var wifiInformation: WifiInfomation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Configure"
        mPasswordLabel.text = "Enter \(wifiInformation.wifiName) password"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func connectButtonClicked(sender: AnyObject) {
        performSegueWithIdentifier("showCPXConfiguring", sender: nil)
    }
    
}
