//
//  ITunesContent.swift
//  FeedApp
//
//  Created by Andrey Novikov on 1/20/21.
//

import Foundation

struct ITunesContent: Decodable {
    let resultCount: Int
    let results: [Result]
}

struct Result: Decodable {
    var trackName: String?
    var kind: String?
    let artistName: String
    var collectionName: String?
    var trackViewUrl: String?
    var previewUrl: String?
    var artworkUrl30: String?
}

extension Result: Equatable {
    static func ==(lhs: Result, rhs: Result) -> Bool {
        return lhs.trackName == rhs.trackName && lhs.kind == rhs.kind && lhs.artistName == rhs.artistName && lhs.collectionName == rhs.collectionName && lhs.trackViewUrl == rhs.trackViewUrl && lhs.previewUrl == rhs.previewUrl
    }
}
