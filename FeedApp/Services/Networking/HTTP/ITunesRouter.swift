//
//  ITunesRouter.swift
//  FeedApp
//
//  Created by Andrey Novikov on 1/19/21.
//

import Foundation

enum Entity: String {
    case none
    case musicVideo
}

enum ITunesRouter {
    case getItems(authorName: String, entity: Entity)
}


// MARK: - HTTPRouter

extension ITunesRouter: HTTPRouter {
    
    // MARK: - Base URL string
    
    var host: String {
        return "itunes.apple.com"
    }
    
    // MARK: - Path
    
    var path: String {
        switch self {
        case .getItems:
            return "/search"
        }
    }
    
    // MARK: - HTTP router
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getItems:
            return .get
        }
    }
    
    // MARK: - Parameters
    
    var parameters: Parameters? {
        switch self {
        case .getItems(let name, let entity):
            var base = [K.ITunesParameterKey.term: name]
            switch entity {
            case .none:
                return base
            case .musicVideo:
                base[K.ITunesParameterKey.entity] = "musicVideo"
                return base
            }
        }
    }
}
