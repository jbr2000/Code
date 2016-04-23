//
//  DeckStatsViewController.swift
//  Everything Magic
//
//  Created by Spencer McWilliams on 11/11/15.
//  Copyright © 2015 Spencer McWilliams. All rights reserved.
//

import Foundation
import UIKit

class DeckStatsViewController: UITableViewController {
    @IBOutlet weak var cmcWebView: UIWebView!
    @IBOutlet weak var manaDistributionWebView: UIWebView!
    @IBOutlet weak var deckNameLabel: UILabel!
    @IBOutlet weak var deckSizeLabel: UILabel!
    
    @IBAction func saveDeckPressed(sender: AnyObject) {
        
    }
        
    override func viewDidLoad() {
        DeckManager.instance.calculateStats()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.backgroundColor = UIColor(patternImage: UIImage(named: "bkg2white")!)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var htmlString: String = String()
        switch indexPath.row {
        case 0: htmlString = HighchartsHelper().generateHTMLForChart(HighchartsHelper.chart.ManaCurve)
        case 1: htmlString = HighchartsHelper().generateHTMLForChart(HighchartsHelper.chart.TypeDistribution)
        case 2: htmlString = HighchartsHelper().generateHTMLForChart(HighchartsHelper.chart.ManaDistribution)
        default: assert(false)
        }
        
        assert(!htmlString.isEmpty)
        let cell = tableView.dequeueReusableCellWithIdentifier("chartCell") as! ChartCell
        cell.backgroundColor = UIColor.clearColor()
        cell.chartWebView.loadHTMLString(htmlString, baseURL: nil)
        
        return cell
    }
}

















