//
//  Life_PadViewController.swift
//  Everything Magic
//
//  Created by Spencer McWilliams on 9/18/15.
//  Copyright (c) 2015 Spencer McWilliams. All rights reserved.
//

import Foundation
import UIKit

class Life_PadViewController: UIViewController {
    var currentPlayer: Int = 0
    @IBOutlet weak var player1TableView: UITableView!
    @IBOutlet weak var player2TableView: UITableView!
    @IBOutlet weak var notesTextView: UITextView!
    @IBAction func resetButtonPressed(sender: UINavigationItem) {
        LifeTotals.sharedInstance.resetTotals(LifeTotals.counterType.Pad)
        self.player1TableView.reloadData()
        self.player2TableView.reloadData()
        self.notesTextView.text = LifeTotals.sharedInstance.trackingString
    }
    @IBAction func addLifeCell(sender: UIButton) {
        LifeTotals.sharedInstance.pad[sender.tag].append(0)
        self.player1TableView.reloadData()
        self.player2TableView.reloadData()
    }
    @IBAction func subLife(sender: UIButton) {
        self.currentPlayer = sender.tag
        let alert = generateAlertView("Subtract")
        alert.show()
    }
    @IBAction func addLife(sender: UIButton) {
        self.currentPlayer = sender.tag
        let alert = generateAlertView("Add")
        alert.show()

    }
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bkg2")!)
        player1TableView.backgroundColor = UIColor.clearColor()
        player2TableView.backgroundColor = UIColor.clearColor()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.notesTextView.text = LifeTotals.sharedInstance.trackingString
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if indexPath.row != 0 {
            return true
        } else {
            return false
        }
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        self.currentPlayer = tableView.tag
        if editingStyle == UITableViewCellEditingStyle.Delete {
            LifeTotals.sharedInstance.pad[self.currentPlayer].removeAtIndex(indexPath.row)
        }
        tableView.reloadData()
    }
    
    func generateAlertView(title: String) -> UIAlertView {
        let alert = UIAlertView(title: "\(title)ing", message: nil, delegate: self, cancelButtonTitle: "Cancel")
        alert.addButtonWithTitle("Done")
        alert.alertViewStyle = UIAlertViewStyle.PlainTextInput
        alert.textFieldAtIndex(0)!.placeholder = "Life to \(title)"
        alert.textFieldAtIndex(0)!.keyboardType = .NumberPad
        return alert
    }
}

extension Life_PadViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LifeTotals.sharedInstance.pad[tableView.tag].count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("lifeCell\(tableView.tag)") as! Life_UITableViewCell
        cell.backgroundColor = UIColor.clearColor()
        cell.lifeField.text = String(LifeTotals.sharedInstance.pad[tableView.tag][indexPath.row])
        return cell
    }
}

extension Life_PadViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(textField: UITextField) {
        let cell = textField.superview?.superview as! Life_UITableViewCell
        let tmpTableView = cell.superview?.superview as! UITableView
        let index = tmpTableView.indexPathForCell(cell)!.row
        if textField.text != "" {
            LifeTotals.sharedInstance.pad[tmpTableView.tag][index] = Int(textField.text!)!
        }
        else {
            textField.text = String(LifeTotals.sharedInstance.pad[tmpTableView.tag][index])
        }
    }
}

extension Life_PadViewController: UITextViewDelegate {
    func textViewDidEndEditing(textView: UITextView) {
        LifeTotals.sharedInstance.trackingString = textView.text
    }
}

extension Life_PadViewController: UIAlertViewDelegate {
    func alertView(alertView: UIAlertView, didDismissWithButtonIndex buttonIndex: Int) {
        self.resignFirstResponder()
        if buttonIndex == 1 {
            var newValue = 0
            switch alertView.title {
            case "Adding": newValue = LifeTotals.sharedInstance.pad[self.currentPlayer].last! + Int(alertView.textFieldAtIndex(0)!.text!)!
            case "Subtracting": newValue = LifeTotals.sharedInstance.pad[self.currentPlayer].last! - Int(alertView.textFieldAtIndex(0)!.text!)!
            default: assert(false)
            }
            LifeTotals.sharedInstance.addLifeIndex(self.currentPlayer, value: newValue)
        }
        self.player1TableView.reloadData()
        self.player2TableView.reloadData()
    }
}