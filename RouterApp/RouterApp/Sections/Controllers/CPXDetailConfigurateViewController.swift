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
  var wifiList:[AnyObject]? {
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
  
  var timmer = NSTimer()
  var device: CPXDevice!

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Configure"
    
    scanWifiNetworks()
    timmer.invalidate()
    titleLabel.text = "Be patient. We are looking for your home router …"
    self.timmer = NSTimer.scheduledTimerWithTimeInterval(45, target: self, selector: #selector(CPXDetailConfigurateViewController.getWifiList), userInfo: nil, repeats: false)
//    getWifiList()
    
//    self.navigationItem.hidesBackButton = true
//    let backTitle = device.location.length > 12 ? "Back" : device.location
//    let newBackButton = UIBarButtonItem(title: backTitle, style: UIBarButtonItemStyle.Plain, target: self, action: #selector(CPXDetailConfigurateViewController.backView(_:)))
//    self.navigationItem.leftBarButtonItem = newBackButton;
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  private func scanWifiNetworks() {
//    startAnimating()    
    UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    APIManager.scanWifiNetworks { (result, error) in
//      self.stopAnimating()
//      if result != nil {
//        // DO nothing for success
//      }
//      else {
//        self.showAlert(withMessage: "Have something wrong, please try again!")
//      }
    }
  }
  
  func getWifiList() {
//    startAnimating()
    UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    APIManager.getWifiList({ (result, error) in
      UIApplication.sharedApplication().networkActivityIndicatorVisible = false
//      self.stopAnimating()
      self.titleLabel.text = "No wifi nearby"
      if result != nil {
        self.wifiList = result
      }
      else {
        self.showAlert(withMessage: "Have something wrong, please try again!")
      }
    })
  }
  
  // MARK: Navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showConfigureDetailSegueIndentifier" {
      let configureDetailViewController = segue.destinationViewController as! CPXConfigureDetailViewController
      let selectedIndexPath = mConfigureTableView.indexPathForSelectedRow!
      guard let listWifi = wifiList else {
        return
      }
      configureDetailViewController.wifiInformation = listWifi[selectedIndexPath.row]
    }
  }
  
//  func backView(sender: UIBarButtonItem) {
//    showAlert(withMessage: "Process will be abord", isPopRootView: false, isPopView: true)
//  }
  
}

extension CPXDetailConfigurateViewController: UITableViewDelegate, UITableViewDataSource {
  // MARK: Table View Data Source
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    //CPXConfigureCell
    let cell = tableView.dequeueReusableCellWithIdentifier(wifiCellIdentifier)
    guard let listWifi = wifiList else {
      return UITableViewCell()
    }
    let wifiInfo = listWifi[indexPath.row]
    guard let ssid = wifiInfo["ssid"] as? String else {
      return UITableViewCell()
    }
    cell?.textLabel?.text = ssid
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
