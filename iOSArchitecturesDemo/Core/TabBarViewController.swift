//
//  TabBarViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Olya Ganeva on 20.03.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    let searchViewController = SearchBuilder.build()
    let songSearchViewController = UIViewController()//SongSearchBuilder.build()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        UITabBar.appearance().barTintColor = .white
        navigationItem.largeTitleDisplayMode = .never
        tabBar.tintColor = UIColor(red: 45/255, green: 129/255, blue: 224/255, alpha: 1)
        setupVCs()
    }

    private func setupVCs() {
        viewControllers = [
            createNavController(for: searchViewController, title: "Apps", image: UIImage(systemName: "person.3")!),
            createNavController(for: songSearchViewController, title: "Songs", image: UIImage(systemName: "person.3")!)
        ]
    }

    fileprivate func createNavController(
        for rootViewController: UIViewController,
        title: String,
        image: UIImage) -> UIViewController {

        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = false
        rootViewController.navigationItem.title = title
        return navController
    }
}

//class TabBarViewController: UITabBarController {
//
//    let searchViewController = SearchBuilder.build()
//    let songSearchViewController = SongSearchBuilder.build()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        UITabBar.appearance().barTintColor = .white
//        navigationItem.largeTitleDisplayMode = .never
//        tabBar.tintColor = UIColor(red: 45/255, green: 129/255, blue: 224/255, alpha: 1)
//        setupVCs()
//    }
//
//    private func setupVCs() {
//        viewControllers = [
//            createNavController(for: searchViewController, title: "Apps", image: UIImage(systemName: "person.3")!),
//            createNavController(for: songSearchViewController, title: "Songs", image: UIImage(systemName: "person.3")!)
//        ]
//    }
//
//    fileprivate func createNavController(
//        for rootViewController: UIViewController,
//        title: String,
//        image: UIImage) -> UIViewController {
//
//        let navController = UINavigationController(rootViewController: rootViewController)
//        navController.tabBarItem.title = title
//        navController.tabBarItem.image = image
//        navController.navigationBar.prefersLargeTitles = false
//        rootViewController.navigationItem.title = title
//        return navController
//    }
//}

//final class AppStatManager {
//
//    var window: UIWindow?
//
//    init(window: UIWindow?) {
//        self.window = window
//    }
//
//    func start() {
//        let appsVC = SearchBuilder.build()
//        let songsVC = SongSearchBuilder.build()
//        appsVC.navigationItem.title = "Search via iTunes"
//        songsVC.navigationItem.title = "Search via iTunes"
//
//        let navVC = self.configuredNavigationController
//        navVC.viewControllers = [appsVC, songsVC]
//
//        window?.rootViewController = navVC
//        window?.makeKeyAndVisible()
//    }
//
//    private lazy var configuredNavigationController: UINavigationController = {
//        let navVC = UINavigationController()
//        navVC.navigationBar.barTintColor = UIColor.varna
//        navVC.navigationBar.isTranslucent = false
//        navVC.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//        navVC.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//        return navVC
//    }()
//}
