//
//  TabBarController.swift
//  Everything Magic
//
//  Created by Spencer McWilliams on 11/19/15.
//  Copyright © 2015 Spencer McWilliams. All rights reserved.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        self.tabBar.barTintColor = UIColor.blackColor()
        self.tabBar.tintColor = UIColor.redColor()
    }
}