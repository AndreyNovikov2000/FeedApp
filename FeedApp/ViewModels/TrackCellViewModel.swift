//
//  TrackCellViewModel.swift
//  FeedApp
//
//  Created by Andrey Novikov on 1/25/21.
//

import Foundation
import RxDataSources

typealias TrackCellSection = SectionModel<Int, TrackCellViewModelPresentable>

protocol TrackCellViewModelPresentable {
    var avatarImageUrlString: String { get }
    var artistName: String { get }
    var date: String { get }
    var tracks: [Track] { get }
}


final class TrackCellViewModel: TrackCellViewModelPresentable {
    var avatarImageUrlString: String
    var tracks: [Track]
    var date: String
    var artistName: String
    
    init(feedCellViewModel: FeedCellViewModelPresentable) {
        avatarImageUrlString = feedCellViewModel.tracks?.first?.trackImage ?? K.DefaultImageURL.imageURL
        tracks = feedCellViewModel.tracks ?? []
        date = feedCellViewModel.formattedDate
        artistName = feedCellViewModel.tracks?.first?.artistName ?? "NoName"
    }
}
