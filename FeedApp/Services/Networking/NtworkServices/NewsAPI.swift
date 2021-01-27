//
//  NewsAPI.swift
//  FeedApp
//
//  Created by Andrey Novikov on 1/19/21.
//

import Foundation
import RxSwift

enum Category: String, CaseIterable {
    case business, entertainment, general, health, science, sports, technology
    
    static func random() -> Category {
        return Category.allCases.randomElement() ?? .business
    }
}

enum Country: String {
    case us, ae, ar, at, au, be, bg
    case br, ca, ch, cn, co, cu, cz
}

protocol NewsAPI {
    func fetchTopBusiness(country: Country, categoty: Category) -> Single<News>
}
