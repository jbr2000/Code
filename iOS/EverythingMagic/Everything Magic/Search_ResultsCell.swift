
//
//  Search_ResultsCell.swift
//  Everything Magic
//
//  Created by Spencer McWilliams on 10/5/15.
//  Copyright © 2015 Spencer McWilliams. All rights reserved.
//

import Foundation
import UIKit

class Search_ResultsCell: UICollectionViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
