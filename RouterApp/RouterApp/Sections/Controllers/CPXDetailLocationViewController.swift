//
//  CPXDetailLocationViewController.swift
//  RouterApp
//
//  Created by Phu Nguyen on 10/25/16.
//
//

import UIKit

class CPXDetailLocationViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  private var defaultLocations = ["Tranning Room", "Bedroom", "Downstairs", "Family Room", "Hallway", "Office", "room of Requirement", "Situation Room", "Upstairs", "Custom"]
  
  var didChooseLocation:((location: String) -> Void)?
  
  var selectedLocation: String! {
    didSet {
      if let index = defaultLocations.indexOf(selectedLocation) {
        selectedIndexPath = index
      }
      else {
        selectedIndexPath = -1
      }
    }
  }
  
  var selectedIndexPath: Int = -1
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Location"
  }
  
  //MARK: - Prepare segue
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == Constants.SegueIdentifer.showAddNewLocationSegueIdentifier {
      if let addNewLocation = segue.destinationViewController as? CPXDetailAddNewLocationViewController {
        addNewLocation.didAddLocation = {
          (newLocation) in
          self.defaultLocations.insert(newLocation, atIndex: 0)
          self.selectedIndexPath = 0
          self.tableView.reloadData()
          if self.didChooseLocation != nil {
            self.didChooseLocation!(location: newLocation)
          }
        }
      }
    }
  }

}



extension CPXDetailLocationViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return defaultLocations.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("CPXDetailLocationCellIdentifier", forIndexPath: indexPath)
    cell.textLabel?.text = defaultLocations[indexPath.row]
    if indexPath.row == selectedIndexPath {
      cell.accessoryType = .Checkmark
    }
    else {
      cell.accessoryType = .None
    }
    return cell
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    if indexPath.row == defaultLocations.count - 1 {
      self.performSegueWithIdentifier(Constants.SegueIdentifer.showAddNewLocationSegueIdentifier, sender: nil)
      return
    }
    
    if let previousCell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: selectedIndexPath, inSection: 0)) { // Remove previous checkmark
      previousCell.accessoryType = .None
    }
    
    let cell = tableView.cellForRowAtIndexPath(indexPath)
    cell?.accessoryType = .Checkmark
    selectedIndexPath = indexPath.row
    if didChooseLocation != nil {
      didChooseLocation!(location: defaultLocations[selectedIndexPath])
    }
  }
}
