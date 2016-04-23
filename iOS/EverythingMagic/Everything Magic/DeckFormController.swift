//
//  DeckFormController.swift
//  Everything Magic
//
//  Created by Spencer McWilliams on 11/9/15.
//  Copyright © 2015 Spencer McWilliams. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class DeckFormController: UIViewController {
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var cardCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        self.navigationController?.delegate = self
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bkg2")!)
        self.cardCollectionView.backgroundColor = UIColor(patternImage: UIImage(named: "bkg2white")!)
        self.cardCollectionView.layer.cornerRadius = 5
        self.cardCollectionView.clipsToBounds = true
    }
    
    @IBAction func updateMultiplier(sender: UIStepper) {
        let cell = sender.superview as! DeckCardCell
        let i = self.cardCollectionView.indexPathForCell(cell)?.row
        DeckManager.instance.cards[i!].1 = Int(sender.value)
        cell.multiplierLabel.text = "x" + String(DeckManager.instance.cards[i!].1)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

extension DeckFormController: UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DeckManager.instance.cards.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("card cell", forIndexPath: indexPath) as! DeckCardCell
        cell.nameLabel.text = DeckManager.instance.cards[indexPath.row].0["name"].string!
        cell.multiplierLabel.text = "x" + String(DeckManager.instance.cards[indexPath.row].1)
        
        let cellQ = dispatch_queue_create("cell queue", nil)
        dispatch_async(cellQ!, {
            // extract card's image url
            print(DeckManager.instance.cards[indexPath.row].2)
            // request data for card's image
            Alamofire.request(.GET, DeckManager.instance.cards[indexPath.row].2).responseData { response in
                // update cell when the data is recieved
                let newCell = collectionView.cellForItemAtIndexPath(indexPath) as? DeckCardCell
                newCell?.imageView.image = UIImage(data: response.result.value!)
                newCell?.activityIndicator.stopAnimating()
            }
        })
        
        return cell
    }
}

// Used to reload data when coming back to the form from selecting a card.
extension DeckFormController: UINavigationControllerDelegate {
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        if (viewController == self.navigationController?.viewControllers[0]) {
            self.cardCollectionView.reloadData()
        }
    }
}