//
//  QueryManager.swift
//  Everything Magic
//
//  Created by Spencer McWilliams on 10/6/15.
//  Copyright © 2015 Spencer McWilliams. All rights reserved.
//

import Foundation
import Parse
import Alamofire

public class QueryManager {
    public static let instance = QueryManager()
    var currentSet: String = String()
    var cards: JSON = nil
    var singleCard: JSON = nil
    
    public func clean(currentSet: Bool, cards: Bool, singleCard: Bool) -> Void {
        if cards      { self.cards = nil           }
        if singleCard { self.singleCard = nil      }
        if currentSet { self.currentSet = String() }
    }
    
    public func getCardsFor(query: NSURL) -> Void {
        self.cards = nil
        Alamofire.request(.GET, query).responseData { response in
            self.cards = JSON.init(data: response.result.value!)
        }
    }
    
    public func getAllCombos() -> Void {
        let allQuery = PFQuery(className: "Combo")
        allQuery.limit = 50
        allQuery.whereKey("creatorusername", notEqualTo: DefaultsManager.instance.getUserName())
        do {
            ComboManager.instance.allCombos = try allQuery.findObjects()
        } catch {
            assert(false, "Caught exception when finding Combos.")
        }
        
        let myQuery = PFQuery(className: "Combo")
        myQuery.limit = 50
        myQuery.whereKey("creatorusername", equalTo: DefaultsManager.instance.getUserName())
        do {
            ComboManager.instance.myCombos = try myQuery.findObjects()
        } catch {
            assert(false, "Caught exception when finding Combos.")
        }
    }
    
    public func saveCombo() -> Void {
        // save combo
        ComboManager.instance.combo.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) { NSLog("Combo Successfully Saved", 0) }
            else         { assert(false, "Unable to save combo") }
        }
    }
}