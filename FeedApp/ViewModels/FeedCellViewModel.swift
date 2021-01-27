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
    
    func rowSize() -> CGFloat
    func collectionViewFrame() -> CGRect
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

extension FeedCellViewModel {
    func rowSize() -> CGFloat {
        switch feedType {
        case .imageContentType:
            switch imageUrls?.count ?? 1 {
            case 1:
                return K.FeedSizes.layout1Size
            case 2:
                return K.FeedSizes.layout2Size
            case 3:
                return K.FeedSizes.layout3Size
            case 4:
                return K.FeedSizes.layout4Size
            default:
                return 0
            }
            
        case .trackType:
            let count = tracks?.count ?? 0
            // 16 padding + 50 imageView + 10 padding to album imageView + 10 padding to tableView + 10 padding to bottom
            let constantHeight: CGFloat = 16 + 50 + 10 + 10 + 10
            let tableViewHeight = CGFloat(count) * K.FeedSizes.imageTrackCellSize
            return constantHeight + tableViewHeight
        }
    }
    
    func collectionViewFrame() -> CGRect {
        let widht = UIScreen.main.bounds.width
        let yOrigin: CGFloat = 10 + 50 + 10
        
        return CGRect(x: 0,
                      y: yOrigin,
                      width: widht,
                      height: rowSize() - yOrigin - 10)
    }
}


