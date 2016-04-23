//
//  Button.swift
//  Everything Magic
//
//  Created by Spencer McWilliams on 11/9/15.
//  Copyright © 2015 Spencer McWilliams. All rights reserved.
//

import Foundation
import UIKit

class Button: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 3
        self.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.backgroundColor = UIColor(hue: 0, saturation: 0.82, brightness: 0.86, alpha: 0.9)
    }
}