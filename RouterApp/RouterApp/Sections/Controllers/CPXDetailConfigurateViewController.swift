//
//  CPXConfigurateViewController.swift
//  RouterApp
//
//  Created by Phu Nguyen on 10/26/16.
//
//

import UIKit

class CPXDetailConfigurateViewController: UIViewController {
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var mConfigureTableView: UITableView!
  var wifiList:[WifiInfo]? {
    didSet {
      if wifiList!.count > 0 {
        mConfigureTableView.hidden = false
        self.mConfigureTableView.reloadData()
        titleLabel.text = "Choose the wifi network you want to connect"
      }
      else {
        titleLabel.text = "No wifi nearby"
        mConfigureTableView.hidden = true
      }
    }
  }
  let wifiCellIdentifier = "CPXConfigureCell"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Configure"
    scanWifiNetworks()
  }
  
  private func scanWifiNetworks() {
    startAnimating()
    APIManager.scanWifiNetworks { (result, error) in
      self.stopAnimating()
      if result != nil {
        self.wifiList = Array(result!)
      }
      else {
        self.showAlert(withMessage: "Have something wrong, please try again!")
      }
    }
  }
  
  // MARK: Navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showConfigureDetailSegueIndentifier" {
      let configureDetailViewController = segue.destinationViewController as! CPXConfigureDetailViewController
      let selectedIndexPath = mConfigureTableView.indexPathForSelectedRow!
      configureDetailViewController.wifiInformation = wifiList![selectedIndexPath.row]
    }
  }
  
}

extension CPXDetailConfigurateViewController: UITableViewDelegate, UITableViewDataSource {
  // MARK: Table View Data Source
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    //CPXConfigureCell
    let cell = tableView.dequeueReusableCellWithIdentifier(wifiCellIdentifier)
    cell?.textLabel?.text = wifiList![indexPath.row].ssid
    return cell!
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // TODO: Hard code
    if wifiList != nil {
      return wifiList!.count
    }
    return 0
  }
  
  // MARK: Table View Delegate
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    performSegueWithIdentifier("showConfigureDetailSegueIndentifier", sender: nil)
  }
}
