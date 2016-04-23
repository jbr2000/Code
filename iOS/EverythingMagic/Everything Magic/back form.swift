//
//  Combo_FormController.swift
//  Everything Magic
//
//  Created by Spencer McWilliams on 10/22/15.
//  Copyright © 2015 Spencer McWilliams. All rights reserved.
//

import Foundation
import UIKit

class Combo_FormController: UICollectionViewController {
    override func viewDidLoad() {
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Combo_FormCell", forIndexPath: indexPath) as! Combo_FormContentView
        switch indexPath.section {
        case 0:
            cell.label.hidden = true
            cell.cardCountStepper.hidden = true
            cell.button.hidden = true
            
            let pickerView = UIPickerView()
            pickerView.delegate = self
            pickerView.dataSource = self
            cell.addSubview(pickerView)
            pickerView.bounds = cell.bounds
        case 1:
            cell.button.hidden = true
            cell.label.text = String(Int(cell.cardCountStepper.value))
        case 2:
            cell.label.hidden = true
            cell.cardCountStepper.hidden = true
            cell.button.titleLabel?.text = "Create"
            
        default: assert(false, "Unexpected Form Section View")
        }
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 3
    }

    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "HeaderView", forIndexPath: indexPath) as! Combo_FormHeader
            switch indexPath.section {
            case 0: headerView.titleLabel.text = "Combo Type"
            case 1: headerView.titleLabel.text = "Number of Cards"
            case 2: headerView.titleLabel.text = ""
            default: headerView.titleLabel.text = "broken"; NSLog("Combo Header label switch broken", 0)
            }
            return headerView
        case UICollectionElementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "FooterView", forIndexPath: indexPath)
            return footerView
        default: assert(false, "Unexpected element kind")
        }
        assert(false, "Unexpected dequeue")
        return UICollectionReusableView()
    }
}

extension Combo_FormContentView: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(self.frame.width * 4/5, self.frame.height/2)
    }
}

extension Combo_FormController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 12
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let values = ["Any", "Artifact/Enchantment Destruction", "Card Drawing", "Creature Destruction", "Damage Prevention", "Hand Disruption", "Infinite Life/Damage/Mana", "Land Destruction", "Life Gain", "Lockdown", "Massive Damage", "Minus the Drawback"]
        return values[row]
    }
}