//
//  K.swift
//  FeedApp
//
//  Created by Andrey Novikov on 1/15/21.
//

import Foundation
import CoreGraphics

struct K {
    
    enum FeedSizes {
        static let layout1Size: CGFloat = 300
        static let layout2Size: CGFloat = 300
        static let layout3Size: CGFloat = 400
        static let layout4Size: CGFloat = 600
        
        static let imageTrackCellSize: CGFloat = 84
    }
    
    enum DefaultImageURL {
        static let imageURL = "https://cdn.arstechnica.net/wp-content/uploads/2016/02/5718897981_10faa45ac3_b-640x624.jpg"
    }
    
    
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
