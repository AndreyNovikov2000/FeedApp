//
//  ImageUnsplashRouter.swift
//  FeedApp
//
//  Created by Andrey Novikov on 1/19/21.
//

import Foundation

enum ImageUnsplashRouter {
    case feed(page: Int)
}


// MARK: - URLRequest

extension ImageUnsplashRouter: HTTPRouter {
    
    // MARK: - Base URL String
    
    var host: String {
        return "api.unsplash.com"
    }
    
    // MARK: - Path
    
    var path: String {
        switch self {
        case .feed:
            return "/photos"
        }
    }
    
    // MARK: - Methods
    
    var parameters: Parameters? {
        switch self {
        case .feed(let page):
            return [K.ImageUnspalshParameterKey.page: "\(page)", K.ImageUnspalshParameterKey.apiKey: K.APIKey.imageUnspashAPIKey]
        }
    }
    
    // MARK: - HTTPMethod
    
    var httpMethod: HTTPMethod {
        switch self {
        case .feed:
            return .get
        }
    }
}
