//
//  BaseCoordinator.swift
//  FeedApp
//
//  Created by Andrey Novikov on 1/14/21.
//

import Foundation

class BaseCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    
    func start() {
        fatalError("You should override this method: \(#function)")
    }
}
