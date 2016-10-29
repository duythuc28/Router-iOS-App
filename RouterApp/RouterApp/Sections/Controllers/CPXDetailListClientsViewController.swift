//
//  CPXDetailListClientsViewController.swift
//  RouterApp
//
//  Created by Phu Nguyen on 10/25/16.
//
//

import UIKit

class CPXDetailListClientsViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var noClientLabel: UILabel!
  
  var clients: [CPXClientInfo]!
  var device: CPXDevice!
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Clients"
    if clients.count > 0 {
      tableView.hidden = false
      noClientLabel.hidden = true
    }
    else {
      tableView.hidden = true
      noClientLabel.hidden = false
    }
  }
  
  @IBAction func fetchCPXInfo(sender: AnyObject) {
    tableView.hidden = true
    noClientLabel.hidden = true
    
    guard let ipAddress = Cache.sharedCache.getObject(forKey: UserDefaultKey.ipAddress) as? String else {
      return
    }
    guard let token = Cache.sharedCache.getObject(forKey: UserDefaultKey.token) as? String else {
      return
    }
    self.startAnimating()
    clients.removeAll()
    APIManager.getCPXDetail(withIP: ipAddress, token: token) { (result, error) in
      self.stopAnimating()
      if result != nil {
        self.device.updateInfo(result)
        self.clients = self.device.clients
        if self.clients.count > 0 {
          self.tableView.hidden = false
          self.noClientLabel.hidden = true
          self.tableView.reloadData()
        }
        else {
          self.tableView.hidden = true
          self.noClientLabel.hidden = false
        }
      }
      else {
        // Show error message for get cpx info
      }
    }
  }
}

extension CPXDetailListClientsViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return clients.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCellWithIdentifier("CPXDetailListClientsTableViewCell", forIndexPath: indexPath) as? CPXDetailListClientsTableViewCell {
      cell
      cell.clientInfo = clients[indexPath.row]
      return cell
    }
    return UITableViewCell()
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 90.0
  }
}
