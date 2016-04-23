//
//  RulesVC.swift
//  Everything Magic
//
//  Created by Spencer McWilliams on 11/30/15.
//  Copyright © 2015 Spencer McWilliams. All rights reserved.
//

import Foundation
import UIKit

class RulesVC: UIViewController {
    @IBOutlet weak var webView: UIWebView!
    @IBAction func toTOC() {
        let url = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("toc", ofType: "html", inDirectory: "rules")!)
        self.webView.loadRequest(NSURLRequest(URL: url))
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bkg2")!)
        let url = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("toc", ofType: "html", inDirectory: "rules")!)
        self.webView.loadRequest(NSURLRequest(URL: url))
        self.webView.layer.cornerRadius = 5
        self.webView.clipsToBounds = true
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}