//
//  NewsAPIRouter.swift
//  FeedApp
//
//  Created by Andrey Novikov on 1/15/21.
//

import Foundation

enum NewsAPIRouter  {
    case topBusiness(country: String, category: String)
    case topHeadlinesFromTechCrunch(source: String)
}


// MARK: - HTTPRouter

extension NewsAPIRouter: HTTPRouter {
    
    // MARK: - Base URL String
    
    var host: String {
        return "newsapi.org"
    }
    
    // MARK: - Path
    
    var path: String {
        switch self {
        case .topBusiness, .topHeadlinesFromTechCrunch:
            return "/v2/top-headlines"
        }
    }
    
    // MARK: - Parameters
    
    var parameters: Parameters? {
        switch self {
        case .topBusiness(let country, let category):
            return [K.NewsAPIParameterKey.country: country, K.NewsAPIParameterKey.category: category, K.NewsAPIParameterKey.apiKey: K.APIKey.newsApiKey]
        case .topHeadlinesFromTechCrunch(let source):
            return  [K.NewsAPIParameterKey.sources: source, K.NewsAPIParameterKey.apiKey: K.APIKey.newsApiKey]
        }
    }
    
    // MARK: - HTTPMethod
    
    var httpMethod: HTTPMethod {
        switch self {
            case .topBusiness, .topHeadlinesFromTechCrunch:
                return .get
        }
    }
}


