//
//  TrackCellDetailViewModel.swift
//  FeedApp
//
//  Created by Andrey Novikov on 1/25/21.
//

import Foundation
import RxDataSources

typealias TrackCellDetailSection = SectionModel<Int, TrackCellDetailViewModelPresentable>

protocol TrackCellDetailViewModelPresentable {
    var trackName: String { get }
    var artistName: String { get }
    var trackImage: String { get }
    var trackURL: String { get }
    var collectionName: String { get }
}


final class TrackCellDetailViewModel: TrackCellDetailViewModelPresentable {
    var trackName: String
    var artistName: String
    var trackImage: String
    var trackURL: String
    var collectionName: String
    
    init(track: Track) {
        trackName = track.trackName.isEmpty ? "NoName" : track.trackName
        artistName = track.artistName
        trackImage = track.trackImage
        trackURL = track.trackUrl.isEmpty ? K.DefaultImageURL.imageURL : track.trackImage
        collectionName = track.collectionName
    }
}
