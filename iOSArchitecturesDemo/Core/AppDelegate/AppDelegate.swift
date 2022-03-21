//
//  AppDelegate.swift
//  iOSArchitecturesDemo
//
//  Created by ekireev on 14.02.2018.
//  Copyright © 2018 ekireev. All rights reserved.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        start()
        return true
    }

    func start() {
        let tabBarVC = UITabBarController()
        let appsVC = SearchBuilder.build()
        let songsVC = SongSearchBuilder.build()
        appsVC.navigationItem.title = "Apps via iTunes"
        songsVC.navigationItem.title = "Songs via iTunes"

        let appsNavVC = configuredNavigationController
        appsNavVC.viewControllers = [appsVC]

        let songsNavVC = configuredNavigationController
        songsNavVC.viewControllers = [songsVC]

        tabBarVC.viewControllers = [appsNavVC, songsNavVC]
        appsNavVC.tabBarItem.title = "Apps"
        songsNavVC.tabBarItem.title = "Songs"

        window = UIWindow()
        window?.rootViewController = tabBarVC
        window?.makeKeyAndVisible()
    }

    private var configuredNavigationController: UINavigationController {
        let navVC = UINavigationController()
        navVC.navigationBar.barTintColor = UIColor.varna
        navVC.navigationBar.isTranslucent = false
        navVC.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navVC.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        return navVC
    }
}
