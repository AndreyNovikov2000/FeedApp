//
//  HTTPRouter.swift
//  FeedApp
//
//  Created by Andrey Novikov on 1/15/21.
//

import Foundation

typealias Parameters = [String: String]

protocol HTTPRouter {
    var host: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var parameters: Parameters? { get }
    
    func asURLRequest() throws -> URLRequest
}

extension HTTPRouter {
    func asURLRequest() throws -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = parameters?.compactMap({ $0 }).map { URLQueryItem(name: $0, value: $1) }
        
        guard let url = urlComponents.url else {
            throw NetworkError.urlRequesstIsNil
        }

        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
        return request
    }
}
