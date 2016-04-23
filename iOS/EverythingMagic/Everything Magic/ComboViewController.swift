//
//  ComboViewController.swift
//  Everything Magic
//
//  Created by Spencer McWilliams on 11/2/15.
//  Copyright © 2015 Spencer McWilliams. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class ComboViewController: UIViewController {
    @IBOutlet weak var cardCollectionView: UICollectionView!
    @IBOutlet weak var comboTypeLabel: UILabel!
    @IBOutlet weak var comboDescriptionTextView: UITextView!
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bkg2")!)
        self.navigationItem.title = ComboManager.instance.combo["name"] as? String
        self.cardCollectionView.backgroundColor = UIColor(patternImage: UIImage(named: "bkg2white")!)
        self.cardCollectionView.layer.cornerRadius = 5
        self.cardCollectionView.clipsToBounds = true
        self.comboTypeLabel.text = ComboManager.instance.combo["type"] as? String
        self.comboDescriptionTextView.text = ComboManager.instance.combo["desc"] as? String
        self.comboDescriptionTextView.backgroundColor = UIColor(patternImage: UIImage(named: "bkg2white")!)
        self.comboDescriptionTextView.layer.cornerRadius = 5
        self.comboDescriptionTextView.clipsToBounds = true
    }
    @IBAction func castVote(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: return
        case 1: return
        case 2: return
        default: assert(false, "Vote Casting Failed")
        }
    }
}

// These methods are used for displaying card thumbnails
extension ComboViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = cardCollectionView.dequeueReusableCellWithReuseIdentifier("card cell", forIndexPath: indexPath) as! CardCell
        cell.cardNameLabel.text = ComboManager.instance.combo["cardnames"][indexPath.row] as? String
        cell.setNeedsLayout()
        cell.backgroundColor = UIColor.clearColor()
        
        let cellQ = dispatch_queue_create("cell queue", nil)
        dispatch_async(cellQ!, {
            // extract card's image url
            let urlString = ComboManager.instance.combo["cardimageurls"][indexPath.row] as! String
            // request data for card's image
            Alamofire.request(.GET, urlString).responseData { response in
                // update cell when the data is recieved
                let newCell = collectionView.cellForItemAtIndexPath(indexPath) as? CardCell
                newCell?.cardImageView.image = UIImage(data: response.result.value!)
                newCell?.networkIndicatorView.stopAnimating()
            }
        })
        return cell
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ComboManager.instance.combo["cardimageurls"].count
    }
    
}