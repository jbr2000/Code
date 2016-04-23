//
//  Combo_FormContentView.swift
//  Everything Magic
//
//  Created by Spencer McWilliams on 10/22/15.
//  Copyright © 2015 Spencer McWilliams. All rights reserved.
//

import Foundation
import UIKit

class Combo_FormContentView: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var cardCountStepper: UIStepper!
    @IBOutlet weak var button: UIButton!
    
    @IBAction func stepperChangedValue(sender: UIStepper) {
        self.label.text = String(Int(sender.value))
    }
}