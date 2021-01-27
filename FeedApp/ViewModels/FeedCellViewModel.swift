//
//  FeedCellViewModel.swift
//  FeedApp
//
//  Created by Andrey Novikov on 1/23/21.
//

import Foundation
import RxSwift
import RxDataSources

typealias FeedSectionItem = SectionModel<Int, FeedCellViewModelPresentable>

protocol FeedCellViewModelPresentable {
    var title: String { get }
    var formattedDate: String { get }
    var avatarImageUrlString: String { get }
    var id: String { get  }
    var feedType: FeedType { get }
    
    var bodyTitle: String? { get }
    var imageUrls: [String]? { get }
    
    var tracks: [Track]? { get }
}

final class FeedCellViewModel: FeedCellViewModelPresentable {
    
    private var dateFormatterForDate: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ssX"
        return df
    }()
    
    private lazy var dateFormatted: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd MMMM hh:mm"
        return df
    }()
    
    private let date: Date
    
    var formattedDate: String {
        return dateFormatted.string(from: date)
    }
    
    var title: String
    var avatarImageUrlString: String
    var id: String
    var feedType: FeedType
    
    var bodyTitle: String?
    var imageUrls: [String]?

    var tracks: [Track]?
    
    init(news: NewsWrapped) {
        title = news.title
        date = dateFormatterForDate.date(from: news.date) ?? Date()
        avatarImageUrlString = news.avatarImageUrlString
        id = news.id
        feedType = news.feedType
        
        bodyTitle = news.bodyTitle
        imageUrls = news.imageUrls
        
        tracks = news.tracks
    }
}


