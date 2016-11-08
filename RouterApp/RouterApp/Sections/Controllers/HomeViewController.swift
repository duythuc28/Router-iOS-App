//
//  HomeViewController.swift
//  RouterApp
//
//  Created by Phu Nguyen on 10/24/16.
//
//

import UIKit

class HomeViewController: UIViewController {
  
  @IBOutlet weak var notFoundLabel: UILabel!
  @IBOutlet weak var currentSSID: UILabel!
  @IBOutlet weak var tableView: UITableView!
  private var scanLAN: ScanLAN?
  private var connectedDevices = [CPXDevice]() {
    didSet {
      if connectedDevices.count > 0 {
        tableView.hidden = false
        tableView.reloadData()
      }
      else {
        tableView.hidden = true
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    currentSSID.text = NetworkingUtil.fetchSSIDInfo()
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.setNavigationBarHidden(false, animated: false)
    title = "Home Mesh"
    startScanning()
    //add data to test
    let device = CPXDevice(name: "12", ip: "132.222.222.222", mac: "aa:aa:ee:rr:gg")
    device.configured = true
    device.location = "123"
    device.configInfo = [
      "bssid" : "C8:3A:35:04:DA:98",
      "channel": 6,
      "encryption" :             [
        "auth_algs":                 [],
        "auth_suites": [
          "PSK"
        ],
        "description": "WPA PSK (CCMP)",
        "enabled": 1,
        "group_ciphers":               [
          "CCMP"
        ],
        "pair_ciphers":             [
          "CCMP"
        ],
        "wep": 0,
        "wpa": 1,
      ],
      "mode": "Master",
      "quality": 94,
      "quality_max": 94,
      "signal": "-27",
      "ssid": "BigoLive"
    ]
    connectedDevices.append(device)
  }
  
  override func viewDidDisappear(animated: Bool) {
    super.viewDidDisappear(animated)
    scanLAN = nil
    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
  }
  
  private func startScanning() {
    tableView.hidden = true
    notFoundLabel.hidden = true
//    startLoadingIndicator()
    UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    if scanLAN == nil {
      scanLAN = ScanLAN.init(delegate: self)
      connectedDevices.removeAll()
    }
    scanLAN?.stopScan()
    scanLAN?.startScan()
  }
  
  @IBAction func showInfo(sender: AnyObject) {
    print("Show info")
  }
  
  @IBAction func reScan(sender: AnyObject) {
    scanLAN = nil
    startScanning()
  }
  
  // MARK: - Helper methods
  private func didSelectErrorDevice(device: CPXDevice) {
    let alerview = UIAlertController(title: "Error", message: "We cannot access this device\nPlease do a factory reset and try to configure it again", preferredStyle: .Alert)
    let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
    let showHowAction = UIAlertAction(title: "Show me how", style: .Default) { (action) in
      let howToConfigureVC = HowToConfigureViewController.instantiateFromStoryboard("Main")
      self.dismissViewControllerAnimated(true, completion: nil)
      self.presentViewController(howToConfigureVC, animated: true, completion: nil)
    }
    alerview.addAction(okAction)
    alerview.addAction(showHowAction)
    presentViewController(alerview, animated: true, completion: nil)
  }
  
  // MARK: - Prepare segue
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == Constants.SegueIdentifer.showCPXDetailSegueIdentifier {
      if let detailVC = segue.destinationViewController as? CPXDetailViewController {
        title = "Home"
        let device = sender as! CPXDevice
        detailVC.device = device        
        // When CPX selected, save request cpx ip address
        Cache.sharedCache.setObject(device.ipAddress, forKey: UserDefaultKey.ipAddress)
        Cache.sharedCache.setObject(device.token, forKey: UserDefaultKey.token)
      }
    }
    else if segue.identifier == Constants.SegueIdentifer.showJoinMeshSegueIdentifier {
      if let joinVC = segue.destinationViewController as? ConfigureForSecondCPX {
        joinVC.configInfo = sender
      }
    }
  }
  
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return connectedDevices.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("HomeTableViewCell", forIndexPath: indexPath) as! HomeTableViewCell
    let device = connectedDevices[indexPath.row]
    cell.device = device
    return cell
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 70
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let device = connectedDevices[indexPath.row]
    if !device.configured { // unconfig device (not authenticate) -> show error pop up
      didSelectErrorDevice(device)
    }
    else { // red or green status, show detail device
      // if the previous cpx have config info, just call api to join
      for (_, obj) in connectedDevices.enumerate() {
        if let configInfo = obj.configInfo where obj.macAddress != device.macAddress && !device.status  {
          self.performSegueWithIdentifier(Constants.SegueIdentifer.showJoinMeshSegueIdentifier, sender: configInfo)
          return
        }
      }
      self.performSegueWithIdentifier(Constants.SegueIdentifer.showCPXDetailSegueIdentifier, sender: device)
    }
  }
}

extension HomeViewController: ScanLANDelegate {
  func scanLANDidFindNewAdrress(address: String!, macAddress: String!, havingHostName hostName: String!) {
    // TODO: hard code for device contains prefix MAC Address 04:F0:21:1A:04:88
    if macAddress != nil {
      if macAddress.containsString("04:F0") {
        let device = CPXDevice(name: hostName, ip: address, mac: macAddress)
        // Authenticate router
        APIManager.authenticateRouter(withIP: address, completion: { (token, error) in
          if token != nil {
            // Call API to get CPX detail
            // Save token for cpx
            device.token = token!
            APIManager.getCPXDetail(withIP: address, token: token!, completion: { (result, error) in
              if result != nil {
                device.updateInfo(result)
                device.status = false
//                self.tableView.reloadData()
              }
              else {
//                self.showAlert(withMessage: "Have something wrong, please try again!")
              }
              self.connectedDevices.append(device)
            })
          }
          else {
            self.connectedDevices.append(device) // cannot authentication, return
            return
//            self.showAlert(withMessage: "Have something wrong, please try again!")
          }
        })
      }
    }
  }
  
  func scanLANDidFinishScanning() {
//    stopLoadingIndicator()
    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    if connectedDevices.count > 0 {
      tableView.hidden = false
      notFoundLabel.hidden = true
    }
    else {
      tableView.hidden = true
      notFoundLabel.hidden = false
    }
  }
  
}


