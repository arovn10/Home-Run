//
//  HomeViewController.swift
//  Home Run
//
//  Created by Alec Rovner on 11/13/23.
//

import Foundation
import UIKit

import UIKit

class HomeViewController: UIViewController {

    
    
    let tabBar = UITabBarController()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTabBar()
    }



    private func setupTabBar() {
        let mapViewController = MapViewController()
        mapViewController.tabBarItem = UITabBarItem(title: "Map", image: UIImage(systemName: "map"), tag: 1)

        let loginViewController = LoginViewController()
        loginViewController.tabBarItem = UITabBarItem(title: "Log-in", image: UIImage(systemName: "person.fill"), tag: 2)
        
        let homePageViewController = HomePageViewController()
        homePageViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)

        tabBar.viewControllers = [homePageViewController, mapViewController, loginViewController]

        // Customize the tab bar appearance if needed
        let appearance = UITabBarAppearance()
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        addChild(tabBar)
            view.addSubview(tabBar.view)
            tabBar.didMove(toParent: self)

        tabBar.tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.tabBar.scrollEdgeAppearance = appearance
        }
    }
        
}

