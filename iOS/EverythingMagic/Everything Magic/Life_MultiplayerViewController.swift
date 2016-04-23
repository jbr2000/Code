//
//  Life_MultiplayerViewController.swift
//  Everything Magic
//
//  Created by Spencer McWilliams on 9/30/15.
//  Copyright © 2015 Spencer McWilliams. All rights reserved.
//

import Foundation
import UIKit

class Life_MultiplayerViewController: UIViewController {
    @IBOutlet weak var p1NameLabel: UITextField!
    @IBOutlet weak var p2NameLabel: UITextField!
    @IBOutlet weak var p3NameLabel: UITextField!
    @IBOutlet weak var p4NameLabel: UITextField!
    
    @IBOutlet weak var p1CDLabel: UILabel!
    @IBOutlet weak var p2CDLabel: UILabel!
    @IBOutlet weak var p3CDLabel: UILabel!
    @IBOutlet weak var p4CDLabel: UILabel!
    
    @IBOutlet weak var p1LifeLabel: UILabel!
    @IBOutlet weak var p1LifeStepper: UIStepper!
    @IBOutlet weak var p2LifeLabel: UILabel!
    @IBOutlet weak var p2LifeStepper: UIStepper!
    @IBOutlet weak var p3LifeLabel: UILabel!
    @IBOutlet weak var p3LifeStepper: UIStepper!
    @IBOutlet weak var p4LifeLabel: UILabel!
    @IBOutlet weak var p4LifeStepper: UIStepper!
    
    @IBOutlet weak var cd21: UILabel!
    @IBOutlet weak var cd21Stepper: UIStepper!
    @IBOutlet weak var cd31: UILabel!
    @IBOutlet weak var cd31Stepper: UIStepper!
    @IBOutlet weak var cd41: UILabel!
    @IBOutlet weak var cd41Stepper: UIStepper!
    
    @IBOutlet weak var cd12: UILabel!
    @IBOutlet weak var cd12Stepper: UIStepper!
    @IBOutlet weak var cd32: UILabel!
    @IBOutlet weak var cd32Stepper: UIStepper!
    @IBOutlet weak var cd42: UILabel!
    @IBOutlet weak var cd42Stepper: UIStepper!
    
    @IBOutlet weak var cd13: UILabel!
    @IBOutlet weak var cd13Stepper: UIStepper!
    @IBOutlet weak var cd23: UILabel!
    @IBOutlet weak var cd23Stepper: UIStepper!
    @IBOutlet weak var cd43: UILabel!
    @IBOutlet weak var cd43Stepper: UIStepper!
    
    @IBOutlet weak var cd14: UILabel!
    @IBOutlet weak var cd14Stepper: UIStepper!
    @IBOutlet weak var cd24: UILabel!
    @IBOutlet weak var cd24Stepper: UIStepper!
    @IBOutlet weak var cd34: UILabel!
    @IBOutlet weak var cd34Stepper: UIStepper!
    
    @IBAction func updateLifeTotals(sender: UIStepper) {
        let newValue = Int(sender.value)
        switch sender.tag {
        case 0:  LifeTotals.sharedInstance.commander[0][0] = newValue
        case 1:  LifeTotals.sharedInstance.commander[0][1] = newValue
        case 2:  LifeTotals.sharedInstance.commander[0][2] = newValue
        case 3:  LifeTotals.sharedInstance.commander[0][3] = newValue
        case 4:  LifeTotals.sharedInstance.commander[1][0] = newValue
        case 5:  LifeTotals.sharedInstance.commander[1][1] = newValue
        case 6:  LifeTotals.sharedInstance.commander[1][2] = newValue
        case 7:  LifeTotals.sharedInstance.commander[1][3] = newValue
        case 8:  LifeTotals.sharedInstance.commander[2][0] = newValue
        case 9:  LifeTotals.sharedInstance.commander[2][1] = newValue
        case 10: LifeTotals.sharedInstance.commander[2][2] = newValue
        case 11: LifeTotals.sharedInstance.commander[2][3] = newValue
        case 12: LifeTotals.sharedInstance.commander[3][0] = newValue
        case 13: LifeTotals.sharedInstance.commander[3][1] = newValue
        case 14: LifeTotals.sharedInstance.commander[3][2] = newValue
        case 15: LifeTotals.sharedInstance.commander[3][3] = newValue
        default: NSLog("updateLifeTotals switch broken", 0)
        }
        updateAllLabels()
    }
    
    @IBAction func resetLife(sender: AnyObject) {
        LifeTotals.sharedInstance.resetTotals(.Commander)
        updateAllSteppers()
        updateAllLabels()
    }
    
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bkg2")!)
        updateAllSteppers()
        updateAllLabels()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func updateAllSteppers() {
        p1LifeStepper.value = Double(LifeTotals.sharedInstance.commander[0][0])
        cd21Stepper.value = Double(LifeTotals.sharedInstance.commander[0][1])
        cd31Stepper.value = Double(LifeTotals.sharedInstance.commander[0][2])
        cd41Stepper.value = Double(LifeTotals.sharedInstance.commander[0][3])
        
        p2LifeStepper.value = Double(LifeTotals.sharedInstance.commander[1][0])
        cd12Stepper.value = Double(LifeTotals.sharedInstance.commander[1][1])
        cd32Stepper.value = Double(LifeTotals.sharedInstance.commander[1][2])
        cd42Stepper.value = Double(LifeTotals.sharedInstance.commander[1][3])
        
        p3LifeStepper.value = Double(LifeTotals.sharedInstance.commander[2][0])
        cd13Stepper.value = Double(LifeTotals.sharedInstance.commander[2][1])
        cd23Stepper.value = Double(LifeTotals.sharedInstance.commander[2][2])
        cd43Stepper.value = Double(LifeTotals.sharedInstance.commander[2][3])
        
        p4LifeStepper.value = Double(LifeTotals.sharedInstance.commander[3][0])
        cd14Stepper.value = Double(LifeTotals.sharedInstance.commander[3][1])
        cd24Stepper.value = Double(LifeTotals.sharedInstance.commander[3][2])
        cd34Stepper.value = Double(LifeTotals.sharedInstance.commander[3][3])
    }
    
    func updateAllLabels() {        
        p1LifeLabel.text = String(LifeTotals.sharedInstance.commander[0][0])
        p2LifeLabel.text = String(LifeTotals.sharedInstance.commander[1][0])
        p3LifeLabel.text = String(LifeTotals.sharedInstance.commander[2][0])
        p4LifeLabel.text = String(LifeTotals.sharedInstance.commander[3][0])
        
        // commander damage from x to y (cdxy)
        cd21.text = String(LifeTotals.sharedInstance.commander[0][1])
        cd31.text = String(LifeTotals.sharedInstance.commander[0][2])
        cd41.text = String(LifeTotals.sharedInstance.commander[0][3])
        
        cd12.text = String(LifeTotals.sharedInstance.commander[1][1])
        cd32.text = String(LifeTotals.sharedInstance.commander[1][2])
        cd42.text = String(LifeTotals.sharedInstance.commander[1][3])
        
        cd13.text = String(LifeTotals.sharedInstance.commander[2][1])
        cd23.text = String(LifeTotals.sharedInstance.commander[2][2])
        cd43.text = String(LifeTotals.sharedInstance.commander[2][3])
        
        cd14.text = String(LifeTotals.sharedInstance.commander[3][1])
        cd24.text = String(LifeTotals.sharedInstance.commander[3][2])
        cd34.text = String(LifeTotals.sharedInstance.commander[3][3])
    }
}

extension Life_MultiplayerViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        updateAllLabels()
        return true
    }

}