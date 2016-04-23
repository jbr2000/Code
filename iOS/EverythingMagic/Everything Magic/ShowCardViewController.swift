//
//  ShowCardViewController.swift
//  Everything Magic
//
//  Created by Spencer McWilliams on 11/27/15.
//  Copyright © 2015 Spencer McWilliams. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class ShowCardViewController: UIViewController {
    var image: UIImage!
    
    @IBOutlet weak var cardImageView: UIImageView!
    
    override func viewDidLoad() {
        assert(self.image != nil)
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bkg2white")!)
        self.cardImageView.image = self.image
        self.cardImageView.layer.cornerRadius = 10
        self.cardImageView.clipsToBounds = true
    }
}