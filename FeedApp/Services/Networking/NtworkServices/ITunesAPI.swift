//
//  ITunesAPI.swift
//  FeedApp
//
//  Created by Andrey Novikov on 1/20/21.
//

import Foundation
import RxSwift

protocol ITunesAPI {
    func getContent(authorName: String, entity: Entity) -> Single<ITunesContent>
}
