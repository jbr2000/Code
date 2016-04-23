//
//  HighchartsHelper.swift
//  Everything Magic
//
//  Created by Spencer McWilliams on 11/27/15.
//  Copyright © 2015 Spencer McWilliams. All rights reserved.
//

import Foundation

public class HighchartsHelper {
    enum chart { case ManaCurve, ManaDistribution, TypeDistribution }
    func generateHTMLForChart(chartType: chart) -> String {
        var htmlString: String = String()
        
        switch chartType {
        case .ManaCurve:
            let path = NSBundle.mainBundle().pathForResource("manaCurveChart", ofType: "html")
            htmlString = try! String(contentsOfFile: path!, encoding: NSUTF8StringEncoding)
            htmlString = htmlString.stringByReplacingOccurrencesOfString("creatureDataPlaceholder", withString: DeckManager.instance.manaCurve["Creature"]!.description)
            htmlString = htmlString.stringByReplacingOccurrencesOfString("spellDataPlaceholder", withString: DeckManager.instance.manaCurve["Spell"]!.description)
            htmlString = htmlString.stringByReplacingOccurrencesOfString("enchantmentDataPlaceholder", withString: DeckManager.instance.manaCurve["Enchantment"]!.description)
            htmlString = htmlString.stringByReplacingOccurrencesOfString("planeswalkerDataPlaceholder", withString: DeckManager.instance.manaCurve["Planeswalker"]!.description)
        case .ManaDistribution:
            let path = NSBundle.mainBundle().pathForResource("manaDistributionChart", ofType: "html")
            htmlString = try! String(contentsOfFile: path!, encoding: NSUTF8StringEncoding)
            htmlString = htmlString.stringByReplacingOccurrencesOfString("blackDataPlaceholder", withString: DeckManager.instance.manaDistribution["B"]!.description)
            htmlString = htmlString.stringByReplacingOccurrencesOfString("blueDataPlaceholder", withString: DeckManager.instance.manaDistribution["U"]!.description)
            htmlString = htmlString.stringByReplacingOccurrencesOfString("greenDataPlaceholder", withString: DeckManager.instance.manaDistribution["G"]!.description)
            htmlString = htmlString.stringByReplacingOccurrencesOfString("redDataPlaceholder", withString: DeckManager.instance.manaDistribution["R"]!.description)
            htmlString = htmlString.stringByReplacingOccurrencesOfString("whiteDataPlaceholder", withString: DeckManager.instance.manaDistribution["W"]!.description)
            htmlString = htmlString.stringByReplacingOccurrencesOfString("colorlessDataPlaceholder", withString: DeckManager.instance.manaDistribution["C"]!.description)
        case .TypeDistribution:
            let path = NSBundle.mainBundle().pathForResource("typeDistributionChart", ofType: "html")
            htmlString = try! String(contentsOfFile: path!, encoding: NSUTF8StringEncoding)
            htmlString = htmlString.stringByReplacingOccurrencesOfString("creatureDataPlaceholder", withString: String(DeckManager.instance.typeDistribution["creature"]!))
            htmlString = htmlString.stringByReplacingOccurrencesOfString("spellDataPlaceholder", withString: String(DeckManager.instance.typeDistribution["spell"]!))
            htmlString = htmlString.stringByReplacingOccurrencesOfString("planeswalkerDataPlaceholder", withString: String(DeckManager.instance.typeDistribution["planeswalker"]!))
            htmlString = htmlString.stringByReplacingOccurrencesOfString("landDataPlaceholder", withString: String(DeckManager.instance.typeDistribution["land"]!))
            htmlString = htmlString.stringByReplacingOccurrencesOfString("spellDrilldownDataPlaceholder", withString: self.parseDrilldownData(DeckManager.instance.typeDistribution))
        }
        return htmlString
    }
    
    private func parseDrilldownData(var data: Dictionary<String, Int>) -> String {
        data.removeValueForKey("spell")
        data.removeValueForKey("planeswalker")
        data.removeValueForKey("creature")
        data.removeValueForKey("land")
        var retStr = "["
        for e in data {
            retStr = retStr.stringByAppendingString("['\(e.0)',\(e.1)],")
        }
        retStr = retStr.substringToIndex(retStr.endIndex.predecessor())
        retStr = retStr.stringByAppendingString("]")
        return retStr
    }
}