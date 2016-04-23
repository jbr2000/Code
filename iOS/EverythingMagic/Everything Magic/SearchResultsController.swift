//  Search_ResultsCollectionViewController.swift
//  Everything Magic
//
//  Created by Spencer McWilliams on 10/5/15.
//  Copyright © 2015 Spencer McWilliams. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class SearchResultsController: UICollectionViewController {
    
    override func viewDidLoad() {
        self.navigationItem.title = "Results"
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bkg2white")!)
        self.collectionView?.backgroundColor = UIColor.clearColor()
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return QueryManager.instance.cards.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("card cell", forIndexPath: indexPath) as! CardCell
        assert(!QueryManager.instance.cards.isEmpty)
        cell.cardNameLabel.text = QueryManager.instance.cards[indexPath.row]["name"].string!
        cell.cardImageView.image = UIImage(named: "Card Placeholder")
//        cell.cardImageView.layer.cornerRadius = 5
//        cell.cardImageView.clipsToBounds = true
        cell.networkIndicatorView.startAnimating()
        cell.backgroundColor = UIColor.clearColor()
        let cellQ = dispatch_queue_create("cell queue", nil)
        
        dispatch_async(cellQ!, {
            // extract card's image url
            var urlString = QueryManager.instance.cards[indexPath.row]["editions"][0]["image_url"].string!
            // find image for specified set
            if !QueryManager.instance.currentSet.isEmpty {
                let editions = QueryManager.instance.cards[indexPath.row]["editions"]
                for var i=0; i<editions.count; i++ {
                    if editions[i]["set_id"].string! == QueryManager.instance.currentSet {
                        urlString = editions[i]["image_url"].string!
                        break
                    }
                }
            }
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
}