//
//  DefaultsManager.swift
//  Everything Magic
//
//  Created by Spencer McWilliams on 11/6/15.
//  Copyright © 2015 Spencer McWilliams. All rights reserved.
//

import Foundation

public class DefaultsManager {
    public static let instance = DefaultsManager()
    
    let userNameKeyConstant = "usernamekey"
    let decksKeyConstant = "deckskey"
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    public func getUserName() -> String {
        return defaults.stringForKey(userNameKeyConstant)!
    }
    
    public func setUserName(name: String) -> Void {
        defaults.setValue(name, forKey: userNameKeyConstant)
    }
    
    public func getDecks() -> [AnyObject] {
        return defaults.arrayForKey(decksKeyConstant)!
    }
    
    public func addDeck(deck: AnyObject) -> Void {
        var decks = defaults.arrayForKey(decksKeyConstant)!
        decks.append(deck)
        defaults.setValue(decks, forKey: decksKeyConstant)
    }
}