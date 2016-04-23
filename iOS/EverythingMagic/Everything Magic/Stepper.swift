//
//  Stepper.swift
//  Everything Magic
//
//  Created by Spencer McWilliams on 11/9/15.
//  Copyright © 2015 Spencer McWilliams. All rights reserved.
//

import Foundation
import UIKit

class Stepper: UIStepper {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setBackgroundImage(UIImage(), forState: UIControlState.Normal)
        self.setBackgroundImage(UIImage(), forState: UIControlState.Disabled)
        self.setDividerImage(UIImage(), forLeftSegmentState: UIControlState.Normal, rightSegmentState: UIControlState.Normal)
        self.setDividerImage(UIImage(), forLeftSegmentState: UIControlState.Disabled, rightSegmentState: UIControlState.Disabled)
        self.setIncrementImage(UIImage(named: "increment"), forState: UIControlState.Normal)
        self.setDecrementImage(UIImage(named: "decrement"), forState: UIControlState.Normal)
    }
}