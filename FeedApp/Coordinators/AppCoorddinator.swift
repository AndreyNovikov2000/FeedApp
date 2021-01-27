//
//  AppCoorddinator.swift
//  FeedApp
//
//  Created by Andrey Novikov on 1/14/21.
//

import UIKit

class AppCoordinator: BaseCoordinator {
    
    lazy var mainTabBarController: MainTabBarController = {
        let mainTabBarController: MainTabBarController = .loadFromXib()
        return mainTabBarController
    }()
    
    let navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        return navigationController
    }()
    
    let window: UIWindow
    
    init?(window: UIWindow?) {
        guard let window = window else { return nil }
        self.window = window
    }
    
    init(window: UIWindow) {
        self.window = window
    }
    
    
    override func start() {
        let feedCoordinator = FeedCoordinator()
        feedCoordinator.start()
        let feedVC = feedCoordinator.feedViewController!
        feedVC.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "paperplane"), selectedImage: nil)

        
        let vc2 = UIViewController()
        let vc3 = UIViewController()
        let vc4 = UIViewController()
        let vc5 = UIViewController()
        
        vc2.view.backgroundColor = .yellow
        vc2.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "doc"), selectedImage: nil)
        
        vc3.tabBarItem.isEnabled = false
        
        vc4.view.backgroundColor = .red
        vc4.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "paperplane"), selectedImage: nil)
        
        vc5.view.backgroundColor = .green
        vc5.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "book"), selectedImage: nil)
        
        mainTabBarController.setViewControllers([feedVC, vc2, vc3, vc4, vc5], animated: true)
        
        window.rootViewController = mainTabBarController
        window.makeKeyAndVisible()
    }
}
