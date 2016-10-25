//
//  CPXDetailViewController.swift
//  RouterApp
//
//  Created by Phu Nguyen on 10/25/16.
//
//

import UIKit

class CPXDetailViewController: UITableViewController {
  enum TypeInfo: Int {
    case Location = 10
    case Clients
    case Advance
    case Configure
    case Optimize
  }
  
  @IBOutlet weak var qualityLabel: UILabel!
  @IBOutlet weak var locationLabel: UILabel!
  
  var device: CPXDevice! {
    didSet {
      self.title = device.name
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.locationLabel.text = device.location
    self.qualityLabel.text = device.quality
  }
  
  //MARK: - Prepare segue
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if let identifier = segue.identifier {
      switch identifier {
      case Constants.SegueIdentifer.showListLocationsSegueIdentifier:
        if let locationVC = segue.destinationViewController as? CPXDetailLocationViewController {
          locationVC.selectedLocation = device.location
          locationVC.didChooseLocation = {
            (location) in
            self.locationLabel.text = location
            self.device.location = location
          }
        }
      case Constants.SegueIdentifer.showListClientsSegueIdentifier:
        if let clientVC = segue.destinationViewController as?  CPXDetailListClientsViewController {
          clientVC.clients = device.clients
        }
      case Constants.SegueIdentifer.showAdvanceSegueIdentifier:
        if let advanced = segue.destinationViewController as? CPXDetailAdvancedViewController {
          advanced.device = self.device
        }
      default:
        break
      }
    }
  }
  
  
  //MARK: - TableViewDataSource & UITableViewDelegate
  
  override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    if device.configured && indexPath.row == 4 {
      return 0
    }
    if indexPath.row < 2 {
      return 70
    }
    else {
      return 50
    }
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    if indexPath.row == 0 {
      return
    }
    if let cell = tableView.cellForRowAtIndexPath(indexPath) {
      switch cell.tag {
      case TypeInfo.Location.rawValue:
        performSegueWithIdentifier(Constants.SegueIdentifer.showListLocationsSegueIdentifier, sender: nil)
      case TypeInfo.Clients.rawValue:
        performSegueWithIdentifier(Constants.SegueIdentifer.showListClientsSegueIdentifier, sender: nil)
      case TypeInfo.Advance.rawValue:
        performSegueWithIdentifier(Constants.SegueIdentifer.showAdvanceSegueIdentifier, sender: nil)
      case TypeInfo.Configure.rawValue:
        performSegueWithIdentifier(Constants.SegueIdentifer.showConfigureSegueIdentifier, sender: nil)
      case TypeInfo.Optimize.rawValue:
        performSegueWithIdentifier(Constants.SegueIdentifer.showOptimizeSegueIdentifier, sender: nil)
      default:
        break
      }
    }
  }

}
