//
//  Combo_FormController.swift
//  Everything Magic
//
//  Created by Spencer McWilliams on 10/25/15.
//  Copyright © 2015 Spencer McWilliams. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class ComboFormController: UIViewController {
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var comboNameField: UITextField!
    @IBOutlet weak var comboDescription: UITextView!
    @IBOutlet weak var cardCollectionView: UICollectionView!
    @IBAction func saveCombo(sender: UIBarButtonItem) {
        ComboManager.instance.prepareComboForSaving(comboNameField.text!, type: ComboManager.types[pickerView.selectedRowInComponent(0)], desc: comboDescription.text!)
        QueryManager.instance.saveCombo()
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        self.navigationController?.delegate = self
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bkg2")!)
        self.cardCollectionView.layer.cornerRadius = 5
        self.cardCollectionView.backgroundColor = UIColor(patternImage: UIImage(named: "bkg2white")!)
        self.cardCollectionView.clipsToBounds = true
        self.pickerView.layer.cornerRadius = 5
        self.pickerView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        self.pickerView.clipsToBounds = true
        self.comboDescription.backgroundColor = UIColor(patternImage: UIImage(named: "bkg2white")!)
        self.comboDescription.layer.cornerRadius = 5
        self.comboDescription.clipsToBounds = true
        ComboManager.instance.clean()
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}




// Used to reload data when coming back to the form from selecting a card.
extension ComboFormController: UINavigationControllerDelegate {
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        if (viewController == self) {
            self.cardCollectionView.reloadData()
        }
    }
}

// Population of the ComboType PickerView
extension ComboFormController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 12
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ComboManager.types[row]
    }
}

// Used for to display cards currently in the combo
extension ComboFormController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = cardCollectionView.dequeueReusableCellWithReuseIdentifier("card cell", forIndexPath: indexPath) as! CardCell
        cell.cardNameLabel.text = ComboManager.instance.cards[indexPath.row]["name"].string!
        cell.backgroundColor = UIColor.clearColor()
        
        let cellQ = dispatch_queue_create("cell queue", nil)
        dispatch_async(cellQ!, {
            // extract card's image url
            let urlString = ComboManager.instance.cards[indexPath.row]["editions"][0]["image_url"].string!
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
        return ComboManager.instance.cards.count
    }
}















