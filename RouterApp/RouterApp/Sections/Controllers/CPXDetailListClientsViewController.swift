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
  
  var clients: [CPXClientInfo]!
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Clients"
  }
  
  @IBAction func fetchCPXInfo(sender: AnyObject) {
    print("Fetch cpx info")
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
