//
//  ViewController.swift
//  MealBookUIKit
//
//  Created by serhat on 3.10.2024.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUp()
    }
    
    func setUp() {
        
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        let searchVC = UINavigationController(rootViewController: SearchTableViewController())
        let downloadVC = UINavigationController(rootViewController: DownloadViewController())
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        downloadVC.tabBarItem = UITabBarItem(title: "Download", image: UIImage(systemName: "arrow.down.circle"), tag: 2)
        tabBar.tintColor = .label
        
        setViewControllers([homeVC,searchVC,downloadVC], animated: true)
    }
    
}

