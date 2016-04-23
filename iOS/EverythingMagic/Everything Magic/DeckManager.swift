//
//  Deck.swift
//  Everything Magic
//
//  Created by Spencer McWilliams on 10/7/15.
//  Copyright © 2015 Spencer McWilliams. All rights reserved.
//

import Foundation

public class DeckManager {
    public static var instance = DeckManager()
    var cardsToAdd = [Bool](count: 100, repeatedValue: false)
    var cards = [(JSON, Int, String)]()
    var manaCurve = [
        "Creature":     [Int](count: 10, repeatedValue: 0),
        "Spell":        [Int](count: 10, repeatedValue: 0),
        "Enchantment":  [Int](count: 10, repeatedValue: 0),
        "Planeswalker": [Int](count: 10, repeatedValue: 0)
    ]
    var manaDistribution = [
        "B":0, "G":0, "R":0,
        "U":0, "W":0, "C":0
    ]
    var typeDistribution = [
        "creature": 0,
        "land": 0,
        "sorcery": 0,
        "instant": 0,
        "enchantment": 0,
        "planeswalker": 0,
        "spell": 0
    ]
    public func clean() -> Void {
        let storage = DeckManager.instance.cards
        DeckManager.instance = DeckManager()
        DeckManager.instance.cards = storage
    }
    public func calculateStats() -> Void {
        // reset stats so they don't stack
        DeckManager.instance.clean()
        // calculate statistics per card
        for card in DeckManager.instance.cards {
            print("Analyzing card: \(card.0["name"].string!)")
            // adjust stats for types
            let types = card.0["types"].array!
            for type in types {
                switch type {
                case "creature":
                    DeckManager.instance.typeDistribution["creature"]! += card.1
                    DeckManager.instance.manaCurve["Creature"]![card.0["cmc"].intValue] += card.1
                case "land":
                    DeckManager.instance.typeDistribution["creature"]! += card.1
                case "sorcery":
                    DeckManager.instance.typeDistribution["sorcery"]! += card.1
                    DeckManager.instance.typeDistribution["spell"]! += card.1
                    DeckManager.instance.manaCurve["Spell"]![card.0["cmc"].intValue] += card.1
                case "instant":
                    DeckManager.instance.typeDistribution["instant"]! += card.1
                    DeckManager.instance.typeDistribution["spell"]! += card.1
                    DeckManager.instance.manaCurve["Spell"]![card.0["cmc"].intValue] += card.1
                case "enchantment":
                    DeckManager.instance.typeDistribution["enchantment"]! += card.1
                    DeckManager.instance.typeDistribution["spell"]! += card.1
                    DeckManager.instance.manaCurve["Enchantment"]![card.0["cmc"].intValue] += card.1
                case "planeswalker":
                    DeckManager.instance.typeDistribution["planeswalker"]! += card.1
                    DeckManager.instance.manaCurve["Planeswalker"]![card.0["cmc"].intValue] += card.1
                default: print("card: '\(card.0["name"].string!)' has type: \(type) however it is not being used for deck statistics... (on purpose)")
                }
            }
            print("typeDistribution: ", DeckManager.instance.typeDistribution)
            print("manaCurve: ", DeckManager.instance.manaCurve)
            
            // adjust deck manaDistribution
            // parse cost into array
            if !card.0["cost"].stringValue.isEmpty {
                let tmpcost = card.0["cost"].string![card.0["cost"].string!.startIndex.advancedBy(1)..<card.0["cost"].string!.endIndex.advancedBy(-1)]
                let cost = tmpcost.componentsSeparatedByString("}{")
                for c in cost {
                    if let colorlessValue = Int(String(c)) {
                        DeckManager.instance.manaDistribution["C"]! += colorlessValue
                    } else {
                        if c != "X" {
                            DeckManager.instance.manaDistribution[String(c)]! += 1
                        }
                    }
                }
            }
            print("manaDistribution: ", DeckManager.instance.manaDistribution)
        }
    }
}