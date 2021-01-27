//
//  NewsService.swift
//  FeedApp
//
//  Created by Andrey Novikov on 1/19/21.
//

import Foundation
import RxSwift

class NewsService: NetworkService {
    static let shared = NewsService()
}


// MARK: - NewsAPI

extension NewsService: NewsAPI {
    func fetchTopBusiness(country: Country, categoty: Category) -> Single<News> {
        return Single.create { [weak self] (single) -> Disposable in
            do {
                let request = try NewsAPIRouter.topBusiness(country: country.rawValue, category: categoty.rawValue).asURLRequest()
                self?.consigureSession(withRequest: request, single: single)
                
            } catch {
                single(.error(error))
            }
            
            return Disposables.create()
        }
    }
}
