//
//  ComboMenuViewController.swift
//  Everything Magic
//
//  Created by Spencer McWilliams on 11/20/15.
//  Copyright © 2015 Spencer McWilliams. All rights reserved.
//

import Foundation
import UIKit

class ComboMenuViewController: UIViewController {
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bkg2")!)
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}