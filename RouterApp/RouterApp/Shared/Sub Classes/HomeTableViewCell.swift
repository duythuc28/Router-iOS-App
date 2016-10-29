//
//  HomeTableViewCell.swift
//  RouterApp
//
//  Created by Phu Nguyen on 10/25/16.
//
//

import UIKit

class HomeTableViewCell: UITableViewCell {
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var statusLabel: UILabel!
  @IBOutlet weak var statusView: UIView!
  var device: CPXDevice! {
    didSet {
      nameLabel.text = device.name
      let status = device.status ? "Online: \(device.quality)%" : "Error"
      let backgroundColor = device.status ? UIColor.greenColor() : UIColor.redColor()
      statusView.backgroundColor = backgroundColor
      statusLabel.text = status
      
      if !device.configured {
        statusView.backgroundColor = UIColor.grayColor()
        statusLabel.text = "Disconnected"
      }
    }
  }

}
