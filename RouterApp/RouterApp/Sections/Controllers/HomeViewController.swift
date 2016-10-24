//
//  HomeViewController.swift
//  RouterApp
//
//  Created by Phu Nguyen on 10/24/16.
//
//

import UIKit

class HomeViewController: UIViewController {
  
  @IBOutlet weak var currentSSID: UILabel!
  @IBOutlet weak var tableView: UITableView!
  private var scanLAN: ScanLAN?
  private var connectedDevices = [CPXDevice]() {
    didSet {
      tableView.reloadData()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    startScanning()
  }
  
  
  
  private func startScanning() {
    self.showLoading()
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
  
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return connectedDevices.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("HomeTableViewCellIdentifier", forIndexPath: indexPath)
    let device = connectedDevices[indexPath.row]
    cell.textLabel?.text = device.macAddress
    cell.detailTextLabel?.text = device.ipAddress
    return cell
  }
}

extension HomeViewController: ScanLANDelegate {
  func scanLANDidFindNewAdrress(address: String!, macAddress: String!, havingHostName hostName: String!) {
    let device = CPXDevice(name: hostName, ip: address, mac: macAddress)
    connectedDevices.append(device)
  }
  
  func scanLANDidFinishScanning() {
    self.hideLoading()
    print("Scan completely")
  }
  
}


