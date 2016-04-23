//
//  Search_EditionsViewController.swift
//  Everything Magic
//
//  Created by Spencer McWilliams on 10/19/15.
//  Copyright © 2015 Spencer McWilliams. All rights reserved.
//

import Foundation
import UIKit

class EditionsViewController: UIPageViewController {
    override func viewDidLoad() {
        let cardEditions: [UIViewController] = [CardViewController()]
        self.setViewControllers(cardEditions, direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
    }
}

extension EditionsViewController: UIPageViewControllerDelegate {
    
}

extension EditionsViewController: UIPageViewControllerDataSource {
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        return nil
    }
}