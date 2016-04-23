//
//  ComboSearchResultsController.swift
//  Everything Magic
//
//  Created by Spencer McWilliams on 10/25/15.
//  Copyright © 2015 Spencer McWilliams. All rights reserved.
//

import Foundation
import UIKit

class ComboSearchResultsController: SearchResultsController {
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        ComboManager.instance.cards.append(QueryManager.instance.cards[indexPath.row])
        self.navigationController?.popToViewController((self.navigationController?.viewControllers[1])!, animated: true)
    }
}