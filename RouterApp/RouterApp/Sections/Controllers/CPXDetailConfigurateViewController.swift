//
//  CPXConfigurateViewController.swift
//  RouterApp
//
//  Created by Phu Nguyen on 10/26/16.
//
//

import UIKit

struct WifiInfomation {
    var wifiName = ""
    var wifiPassword = ""
}

class CPXDetailConfigurateViewController: UIViewController {
  
    @IBOutlet weak var mConfigureTableView: UITableView!
    var wifiList = [WifiInfomation(wifiName: "Wifi 1", wifiPassword: ""), WifiInfomation(wifiName: "Wifi 2", wifiPassword: "")]
    let wifiCellIdentifier = "CPXConfigureCell"
    
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Configure"
  }
    
    // MARK: Navigation 
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showConfigureDetailSegueIndentifier" {
            let configureDetailViewController = segue.destinationViewController as! CPXConfigureDetailViewController
            let selectedIndexPath = mConfigureTableView.indexPathForSelectedRow!
            configureDetailViewController.wifiInformation = wifiList[selectedIndexPath.row]
        }
    }

}

extension CPXDetailConfigurateViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: Table View Data Source
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //CPXConfigureCell
        let cell = tableView.dequeueReusableCellWithIdentifier(wifiCellIdentifier)
        cell?.textLabel?.text = wifiList[indexPath.row].wifiName
        return cell!
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: Hard code
        return wifiList.count
    }
    
    // MARK: Table View Delegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("showConfigureDetailSegueIndentifier", sender: nil)
    }
}
