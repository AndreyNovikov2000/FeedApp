//
//  MainTabBarController.swift
//  FeedApp
//
//  Created by Andrey Novikov on 1/16/21.
//

import UIKit

final class MainTabBarController: UITabBarController {

    // MARK: - Private properties
    
    private var side: CGFloat {
        tabBar.frame.width / CGFloat((viewControllers?.count ?? 0))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let feedViewController = FeedViewController()
        
        
        feedViewController.builder = { input in
            let newsService = NewsService()
            let imageService = ImageUnsplashService()
            let itunesService = ITunesService()
            let viewModel = FeedViewModel(input: input, services: (newsService: newsService, imageService: imageService, itunesService: itunesService))
            return viewModel
        }
        
        delegate = self
        
        if let tabPlusButton = (tabBar as? CustomTabBar)?.addButton {
            tabPlusButton.addTarget(self, action: #selector(hablePlusButtonTapped), for: .touchUpInside)
        }
        
        tabBar(tabBar, didSelect: feedViewController.tabBarItem)
    }
    
    // MARK: - Selector methods
    
    @objc private func hablePlusButtonTapped() {
        print("Add button tapped: \(#function)")
    }
}


// MARK: - UITabBarControllerDelegate

extension MainTabBarController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let index = (viewControllers?.firstIndex { $0.tabBarItem === item } ?? 0) + 1
        
        if let cutomTabBar = tabBar as? CustomTabBar {
            let pointViewXPosition = CGFloat(index) * side - side / 2
            
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.85,
                           initialSpringVelocity: 0.85,
                           options: .curveEaseOut) {
                
                cutomTabBar.pointView.center.x = pointViewXPosition
            } completion: { (_) in
                
            }
        }
    }
}
