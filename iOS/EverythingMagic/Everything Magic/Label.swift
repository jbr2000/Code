//
//  Label.swift
//  Everything Magic
//
//  Created by Spencer McWilliams on 11/11/15.
//  Copyright © 2015 Spencer McWilliams. All rights reserved.
//

import Foundation
import UIKit

class Label: UILabel {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
        self.textColor = UIColor.whiteColor()
        self.backgroundColor = UIColor(hue: 0, saturation: 0.82, brightness: 0.86, alpha: 0.9)
    }
}