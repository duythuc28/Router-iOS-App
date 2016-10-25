//
//  CPXDetailListClientsTableViewCell.swift
//  RouterApp
//
//  Created by Phu Nguyen on 10/25/16.
//
//

import UIKit

class CPXDetailListClientsTableViewCell: UITableViewCell {
  @IBOutlet weak var macAddressLabel: UILabel!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var ipAddressLabel: UILabel!
  
  var clientInfo: CPXClientInfo! {
    didSet {
      macAddressLabel.text = clientInfo.macAddress
      nameLabel.text = clientInfo.name
      ipAddressLabel.text = clientInfo.ipAddress
    }
  }

}
