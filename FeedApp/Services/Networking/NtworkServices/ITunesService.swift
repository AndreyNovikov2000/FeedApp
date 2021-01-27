//
//  ITunesService.swift
//  FeedApp
//
//  Created by Andrey Novikov on 1/20/21.
//

import Foundation
import RxSwift

class ITunesService: NetworkService {
    static let shared = ITunesService()
}


// MARK: - ITunesAPI

extension ITunesService: ITunesAPI {
    func getContent(authorName: String, entity: Entity) -> Single<ITunesContent> {
        Single.create { [weak self] (single) -> Disposable in
        
            do {
                let request = try ITunesRouter.getItems(authorName: authorName, entity: entity).asURLRequest()
                self?.consigureSession(withRequest: request, single: single)
            } catch {
                single(.error(error))
            }
            
            return Disposables.create()
        }
    }
}
