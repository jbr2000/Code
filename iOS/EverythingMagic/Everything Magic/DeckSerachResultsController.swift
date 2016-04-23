//
//  DeckSerachResultsController.swift
//  Everything Magic
//
//  Created by Spencer McWilliams on 11/9/15.
//  Copyright © 2015 Spencer McWilliams. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class DeckSearchResultsController: SearchResultsController {
    @IBAction func addCardsToDeck(sender: AnyObject) {
        for (index, card) in DeckManager.instance.cardsToAdd.enumerate() {
            if card {
                var urlString = String()
                if QueryManager.instance.currentSet.isEmpty {
                    urlString = QueryManager.instance.cards[index]["editions"][0]["image_url"].string!
                }
                else {
                    let editions = QueryManager.instance.cards[index]["editions"]
                    for var i=0; i<editions.count; i++ {
                        if editions[i]["set_id"].string! == QueryManager.instance.currentSet {
                            urlString = editions[i]["image_url"].string!
                            break
                        }
                    }
                }
                DeckManager.instance.cards.append((QueryManager.instance.cards[index], 1, urlString))
            }
        }
        print(DeckManager.instance.cards)
        DeckManager.instance.clean()
        self.navigationController?.popToViewController((self.navigationController?.viewControllers[0])!, animated: true)
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        DeckManager.instance.cardsToAdd[indexPath.row] = !DeckManager.instance.cardsToAdd[indexPath.row]
        self.collectionView!.reloadItemsAtIndexPaths([indexPath])
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("card cell", forIndexPath: indexPath) as? DeckResultsCardCell
        cell?.cardNameLabel.text = QueryManager.instance.cards[indexPath.row]["name"].string!
        cell?.cardImageView.image = UIImage(named: "Card Placeholder")
        cell?.networkIndicatorView.startAnimating()
        cell?.addMarker.hidden = !DeckManager.instance.cardsToAdd[indexPath.row]
        cell?.backgroundColor = UIColor.clearColor()
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
        return cell!    }
}