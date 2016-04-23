//
//  ComboManager.swift
//  Everything Magic
//
//  Created by Spencer McWilliams on 10/23/15.
//  Copyright © 2015 Spencer McWilliams. All rights reserved.
//

import Foundation
import Parse

public class ComboManager {
    public static let instance = ComboManager()
    
    public static let types = ["Any", "Artifact/Enchantment Destruction",
        "Card Drawing", "Creature Destruction", "Damage Prevention",
        "Hand Disruption", "Infinite Life/Damage/Mana", "Land Destruction",
        "Life Gain", "Lockdown", "Massive Damage", "Minus the Drawback"]
    
    var combo   = PFObject(className: "Combo")
    var cards   = [JSON]()
    var allCombos  = [PFObject]()
    var myCombos = [PFObject]()
    var cardNames = [String]()
    var cardImageURLs = [String]()

    public func clean() -> Void {
        self.combo = PFObject(className: "Combo")
        self.cards = [JSON]()
        self.allCombos = [PFObject]()
        self.myCombos = [PFObject]()
        self.cardNames = [String]()
        self.cardImageURLs = [String]()
    }
    
    public func setComboForIndexPath(indexPath: NSIndexPath) -> Void {
        switch indexPath.section {
        case 0: self.combo = self.myCombos[indexPath.row]
        case 1: self.combo = self.allCombos[indexPath.row]
        default: assert(false, "Failed to set combo")
        }
    }
    
    public func prepareComboForSaving(name: String, type: String, desc: String) -> Void {
        var comboColors = [String]()
        // generate card data
        for card in self.cards {
            self.cardNames.append(card["name"].stringValue)
            self.cardImageURLs.append(card["editions"][0]["image_url"].stringValue)
            // set colors
            for (var i=0; i<card["colors"].count; i++) {
                if !comboColors.contains(card["colors"][i].stringValue) {
                    comboColors.append(card["colors"][i].stringValue)
                }
            }
        }
        comboColors.sortInPlace()
        // set combo values
        self.combo["cardnames"] = cardNames
        self.combo["cardimageurls"] = cardImageURLs
        self.combo["name"] = name
        self.combo["type"] = type
        self.combo["desc"] = desc
        self.combo["score"] = 0
        self.combo["colors"] = comboColors
        self.combo["creatorusername"] = DefaultsManager.instance.getUserName()
    }
}