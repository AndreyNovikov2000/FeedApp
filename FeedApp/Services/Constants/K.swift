//
//  K.swift
//  FeedApp
//
//  Created by Andrey Novikov on 1/15/21.
//

import Foundation

struct K {
    enum APIKey {
        static let newsApiKey = "709cad85b3b54de090143a9f317c98a5"
        static let imageUnspashAPIKey = "cXGzxKCGkVaE6tAof-tX1RY45G0gs85gPUo4wPBz8as"
    }
    
    // post
    enum NewsAPIParameterKey {
        static let apiKey = "apiKey"
        static let country = "country"
        static let category = "category"
        static let sources = "sources"
    }
    
    // image
    enum ImageUnspalshParameterKey {
        static let apiKey = "client_id"
        static let page = "page"
    }
    
    // music & vidio
    enum ITunesParameterKey {
        static let term = "term"
        static let entity = "entity"
    }
}
