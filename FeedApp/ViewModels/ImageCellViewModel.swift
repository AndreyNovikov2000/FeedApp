//
//  ImageCellViewModel.swift
//  FeedApp
//
//  Created by Andrey Novikov on 1/25/21.
//

import Foundation
import RxDataSources

typealias ImageSectionItem = SectionModel<Int, ImageCellViewModelPresentable>

protocol ImageCellViewModelPresentable {
    var urlString: String { get }
}

final class ImageCellViewModel: ImageCellViewModelPresentable {
    var urlString: String
    
    init(urlString: String) {
        self.urlString = urlString
    }
}
