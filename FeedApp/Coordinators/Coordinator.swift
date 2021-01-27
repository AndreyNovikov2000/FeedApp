//
//  Coordinator.swift
//  FeedApp
//
//  Created by Andrey Novikov on 1/14/21.
//

import Foundation

protocol Coordinator: class {
    var coordinators: [Coordinator] { get set }
    func start()
}

extension Coordinator {
    func add(_ coordinator: Coordinator) {
        coordinators.append(coordinator)
    }
    
    func remove(_ coordinator: Coordinator) {
        coordinators = coordinators.filter { $0 !== coordinator }
    }
}
