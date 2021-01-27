//
//  ImageUnsplashAPI.swift
//  FeedApp
//
//  Created by Andrey Novikov on 1/19/21.
//

import Foundation
import RxSwift

protocol ImageUnsplashAPI {
    func fetchImages(withPage page: Int) -> Single<ImageUnsplash>
}
