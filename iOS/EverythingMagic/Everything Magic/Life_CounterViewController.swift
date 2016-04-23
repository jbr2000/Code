//
//  Life_CounterViewController.swift
//  Everything Magic
//
//  Created by Spencer McWilliams on 9/16/15.
//  Copyright (c) 2015 Spencer McWilliams. All rights reserved.
//

import Foundation
import UIKit

class Life_CounterViewController: UIViewController {
    @IBOutlet weak var player1LifeLabel: UILabel!
    @IBOutlet weak var player2LifeLabel: UILabel!
    @IBAction func resetPressed(sender: AnyObject) {
        LifeTotals.sharedInstance.resetTotals(.Standard)
        updateLifeLabels()
    }
    
    func updateLifeLabels() {
        player1LifeLabel.text = String(LifeTotals.sharedInstance.standard[0])
        player2LifeLabel.text = String(LifeTotals.sharedInstance.standard[1])
    }
    
    @IBAction func incrementLife(sender: AnyObject) {
        LifeTotals.sharedInstance.incrementLife(LifeTotals.counterType.Standard, player: sender.tag!)
        updateLifeLabels()
    }
    
    @IBAction func decrementLife(sender: AnyObject) {
        LifeTotals.sharedInstance.decrementLife(LifeTotals.counterType.Standard, player: sender.tag!)
        updateLifeLabels()
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bkg2")!)
        player2LifeLabel.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
        player1LifeLabel.text      = String(LifeTotals.sharedInstance.standard[0])
        player2LifeLabel.text      = String(LifeTotals.sharedInstance.standard[1])
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}