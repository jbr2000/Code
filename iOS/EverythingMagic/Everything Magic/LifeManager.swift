//
//  Life_LifeTotals.swift
//  Everything Magic
//
//  Created by Spencer McWilliams on 9/16/15.
//  Copyright (c) 2015 Spencer McWilliams. All rights reserved.
//

import Foundation

public class LifeTotals {
    
    public static let sharedInstance = LifeTotals()
    let lifeIndex = 0
    var standard: [Int] = [20,20]
    var commander: [[Int]] = [[40],[40],[40],[40]]
    var pad: [[Int]] = [[20],[20]]
    var commanderNames: [String] = ["Player 1", "Player 2", "Player 3", "Player 4"]
    var trackingString = "Notes"
    
    public enum counterType {
        case Standard
        case Commander
        case Pad
    }
    
    init() {
        resetTotals(.Standard)
        resetTotals(.Pad)
        resetTotals(.Commander)
    }
    
    func incrementLife(counter: LifeTotals.counterType, player: Int) {
        switch counter {
        case .Standard: standard[player]++
        case .Commander: commander[player][lifeIndex]++
        default: NSLog("incrementLife switch Broken", 0)
        }
    }
    
    func decrementLife(counter: LifeTotals.counterType, player: Int) {
        switch counter {
        case .Standard: standard[player]--
        case .Commander: commander[player][lifeIndex]--
        default: NSLog("decrementLife switch broken", 0)
        }
    }
    
    func addLifeIndex(player: Int, value: Int) {
        pad[player].append(value)
    }
    
    func resetTotals(counter: LifeTotals.counterType) {
        switch counter {
        case .Standard:
            standard = [20,20]
        case .Pad:
            pad[0] = [20]
            pad[1] = [20]
            trackingString = "Notes"
        case .Commander:
            commanderNames = ["Player 1", "Player 2", "Player 3", "Player 4"]
            commander = [[40,0,0,0],[40,0,0,0],[40,0,0,0],[40,0,0,0]]
        }
    }
}