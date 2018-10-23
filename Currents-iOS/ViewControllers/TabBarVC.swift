//
//  TabVC.swift
//  Currents-iOS
//
//  Created by Ethan Hu on 9/26/18.
//  Copyright © 2018 CUSD Currents. All rights reserved.
//

import UIKit

class TabVC: UITabBarController, UITabBarControllerDelegate {
    
    var discoverNavVC = UINavigationController()
    var myEventsNavVC = UINavigationController()
    var myProfileNavVC = UINavigationController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        setUpViewControllers()
        
        // Tab Bar
        tabBar.tintColor = UIColor(named: "primaryPink") // Icon color of Active tab
        tabBar.unselectedItemTintColor = UIColor.gray // Icon color of Inactive tab
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setUpViewControllers() {
        discoverNavVC = makeNavVC(viewController: EventsDiscoveryController(), title: NSLocalizedString("discover", comment: ""), tabBarIcon: #imageLiteral(resourceName: "magnifyingGlass"))
        myEventsNavVC = makeNavVC(viewController: MyEventsViewController(), title: NSLocalizedString("my-events", comment: ""), tabBarIcon: #imageLiteral(resourceName: "magnifyingGlass"))
        myProfileNavVC = makeNavVC(viewController: MyProfileViewController(), title: NSLocalizedString("my-profile", comment: ""), tabBarIcon: #imageLiteral(resourceName: "magnifyingGlass"))
        
        let controllers = [discoverNavVC, myEventsNavVC, myProfileNavVC]
        self.viewControllers = controllers
    }
    
    private func makeNavVC(viewController: UIViewController, title: String, tabBarIcon: UIImage) -> UINavigationController {
        // Set up each view controller's tab bar
        let tabBarItem = UITabBarItem(title: title, image: tabBarIcon, selectedImage: tabBarIcon)
        viewController.tabBarItem = tabBarItem
        
        // Set up each view controller's nav bar
        viewController.navigationItem.title = title
        
        let navVC = UINavigationController(rootViewController: viewController)
        return navVC
    }
    
}
