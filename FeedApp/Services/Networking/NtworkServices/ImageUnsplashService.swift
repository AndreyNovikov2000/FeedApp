//
//  ImageUnsplashService.swift
//  FeedApp
//
//  Created by Andrey Novikov on 1/15/21.
//

import Foundation
import RxSwift

class ImageUnsplashService: NetworkService {
    static let shared = ImageUnsplashService()
}


// MARK: - ImageUnsplashAPI

extension ImageUnsplashService: ImageUnsplashAPI {
    func fetchImages(withPage page: Int) -> Single<ImageUnsplash> {
        return Single.create { [weak self] (single) -> Disposable in
           
            do {
                let request = try ImageUnsplashRouter.feed(page: page).asURLRequest()
                self?.consigureSession(withRequest: request, single: single)
            } catch {
                single(.error(error))
            }
            
            return Disposables.create()
        }
    }
}
