//
//  FeedCoordinator.swift
//  FeedApp
//
//  Created by Andrey Novikov on 1/14/21.
//

import UIKit

class FeedCoordinator: BaseCoordinator {
    
    var navigationController: UINavigationController?
    var feedViewController: FeedViewController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override init() {
        navigationController = nil
    }
    
    
    
    override func start() {
        let feedViewController = FeedViewController()
        self.feedViewController = feedViewController
        feedViewController.builder = { input in
            let newsService = NewsService()
            let imageService = ImageUnsplashService()
            let itunesService = ITunesService()
            let viewModel = FeedViewModel(input: input, services: (newsService: newsService, imageService: imageService, itunesService: itunesService))
            return viewModel
        }

        
        if let navigationController = navigationController {
            navigationController.pushViewController(feedViewController, animated: false)
        }
    }
}
