//
//  SearchResultsViewController.swift
//  Everything Magic
//
//  Created by Spencer McWilliams on 10/25/15.
//  Copyright © 2015 Spencer McWilliams. All rights reserved.
//

import Foundation
import UIKit

class GenericSearchResultsController: SearchResultsController {
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        QueryManager.instance.singleCard = QueryManager.instance.cards[indexPath.row]
        performSegueWithIdentifier("showCard", sender: collectionView.cellForItemAtIndexPath(indexPath))
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var svc = segue.destinationViewController as! ShowCardViewController
        svc.image = (sender as! CardCell).cardImageView.image
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(false)
    }
}