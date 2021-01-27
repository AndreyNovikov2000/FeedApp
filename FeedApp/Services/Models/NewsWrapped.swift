//
//  NewsWrapped.swift
//  FeedApp
//
//  Created by Andrey Novikov on 1/23/21.
//

import Foundation

struct NewsWrapped {
    // required
    let title: String
    let date: String
    let avatarImageUrlString: String
    let id: String
    let feedType: FeedType
    
    // optinal
    
    // content with images
    var bodyTitle: String?
    var imageUrls: [String]?
    
    // content with music
    var tracks: [Track]?
}

struct Track {
    let artistName: String
    let trackName: String
    let trackImage: String
    let trackUrl: String
    let collectionName: String
}
