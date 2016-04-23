//
//  GenericSearchController.swift
//  Everything Magic
//
//  Created by Spencer McWilliams on 11/19/15.
//  Copyright © 2015 Spencer McWilliams. All rights reserved.
//

import Foundation
import UIKit

class GenericSearchController: SearchFormController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let adjustForTabbarInsets = UIEdgeInsetsMake(0, 0, CGRectGetHeight(self.tabBarController!.tabBar.frame), 0)
        self.tableView.contentInset = adjustForTabbarInsets
        self.tableView.scrollIndicatorInsets = adjustForTabbarInsets
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
//        let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Search, target: self, action: "search:")
//        let item = UINavigationItem(title: "search")
//        item.setRightBarButtonItem(button, animated: false)
    }
}