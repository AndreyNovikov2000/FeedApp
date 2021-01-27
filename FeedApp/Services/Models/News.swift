//
//  APINews.swift
//  FeedApp
//
//  Created by Andrey Novikov on 1/19/21.
//

import Foundation

struct News: Decodable {
    let status: String
    let totalResults: Int
    var articles: [Article]
}

struct Article: Decodable {
    let source: Source
    var author: String?
    var articleDescription: String?
    let title: String
    let url: String
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
}

struct Source: Decodable {
    let id: String?
    let name: String
}
