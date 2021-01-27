//
//  ImageUnsplash.swift
//  FeedApp
//
//  Created by Andrey Novikov on 1/19/21.
//

import Foundation

typealias ImageUnsplash = [ImageRessponse]

struct ImageRessponse: Decodable {
    let id: String
    let createdAt, updatedAt, promotedAt: String
    let width, height: Int
    let altDescription: String?
    let urls: ImageURLS
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case promotedAt = "promoted_at"
        case width, height
        case altDescription = "alt_description"
        case urls
    }
}

struct ImageURLS: Decodable {
    let raw, full, regular, small, thumb: String
}

extension ImageURLS: Equatable {
    static func ==(lhs: ImageURLS, rhs: ImageURLS) -> Bool {
        return lhs.small == rhs.small
    }
}
