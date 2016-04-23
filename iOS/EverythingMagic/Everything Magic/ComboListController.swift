//
//  ComboListController.swift
//  Everything Magic
//
//  Created by Spencer McWilliams on 10/27/15.
//  Copyright © 2015 Spencer McWilliams. All rights reserved.
//

import Foundation
import UIKit
import Parse

class ComboBrowserController: UITableViewController {    
    override func viewDidLoad() {
        QueryManager.instance.getAllCombos()
        self.tableView.backgroundColor = UIColor(patternImage: UIImage(named: "bkg2white")!)
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return ComboManager.instance.myCombos.count
        case 1: return ComboManager.instance.allCombos.count
        default: assert(false, "Invalid index for number of rows in section for ComboIndexViewController")
        }
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("combo cell") as! ComboCell
        var combo = PFObject(className: "Combo")
        
        switch indexPath.section {
        case 0: combo = ComboManager.instance.myCombos[indexPath.row]
        case 1: combo = ComboManager.instance.allCombos[indexPath.row]
        default: assert(false, "Invalid index for IndexPath.section")
        }
        
        cell.titleLabel.text = combo["name"] as? String
        cell.typeLabel.text = combo["type"] as? String
        cell.backgroundColor = UIColor.clearColor()
        
        let colors: [String] = Array(combo["colors"] as! [String])
        if colors.contains("black") { cell.black.hidden = false }
        if colors.contains("blue")  { cell.blue.hidden  = false }
        if colors.contains("green") { cell.green.hidden = false }
        if colors.contains("red")   { cell.red.hidden   = false }
        if colors.contains("white") { cell.white.hidden = false }
        
        return cell
    }
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "My Combos"
        case 1: return "All Combos"
        default: assert(false, "Incorrect index for seciton header")
        }
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        ComboManager.instance.setComboForIndexPath(indexPath)
        performSegueWithIdentifier("showCombo", sender: self)
    }
}