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
  
  private var defaultLocations = [String]()
  
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
  var deviceName: String = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Location"
    let locations = realmDB.objects(Location.self).sorted("createdAt").reverse()
    for lot in locations {
      defaultLocations.append(lot.name)
    }
    
    if let index = defaultLocations.indexOf(selectedLocation) {
      selectedIndexPath = index
    }
    else { // not found, add new db
      let new = Location(locationName: selectedLocation)
      try! realmDB.write({
        realmDB.add(new)
      })
      selectedIndexPath = defaultLocations.count
      defaultLocations.insert(selectedLocation, atIndex: 0)
    }
    defaultLocations.append("Custom")
  }
  
  //MARK: - Prepare segue
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == Constants.SegueIdentifer.showAddNewLocationSegueIdentifier {
      if let addNewLocation = segue.destinationViewController as? CPXDetailAddNewLocationViewController {
        addNewLocation.didAddLocation = {
          (newLocation) in
          let new = Location(locationName: newLocation)
          try! realmDB.write({
            realmDB.add(new)
          })
          self.defaultLocations.insert(newLocation, atIndex: 0)
          self.selectedIndexPath = 0
          self.tableView.reloadData()
          self.updateCPXInfo()
        }
      }
    }
  }
  
  private func updateCPXInfo() {
    selectedLocation = defaultLocations[selectedIndexPath]
    self.startAnimating()
    APIManager.updateCPXInfo(withName: deviceName, location: selectedLocation) { (result, error) in
      self.stopAnimating()
      if result != nil {
        print(result)
        if self.didChooseLocation != nil {
          self.didChooseLocation!(location: self.selectedLocation)
        }
      }
      else {
        self.showAlert(withMessage: "Have something wrong, please try again!")
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
    // Update cpx info
    updateCPXInfo()
  }
}
