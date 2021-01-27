//
//  NetworkService.swift
//  FeedApp
//
//  Created by Andrey Novikov on 1/20/21.
//

import Foundation
import RxSwift

typealias NetworkResponse = (Data?, URLResponse?, Error?) -> Void

class NetworkService: DecodeRepresentable {
    var session: URLSession
    
    init() {
        session = URLSession.shared
    }
    
    init(configuration: URLSessionConfiguration, delegate: URLSessionDelegate?, delegateQueue: OperationQueue?) {
        session = URLSession(configuration: configuration, delegate: delegate, delegateQueue: delegateQueue)
    }
}

extension NetworkService {
    func configureSingle<T: Decodable>(single:@escaping Single<T>.SingleObserver) -> NetworkResponse {
        return { (data, _, error) in
            guard let data = data else {
                single(.error(NetworkError.emptyData))
                return
            }
            
            do {
                let value: T = try self.decode(data: data)
                single(.success(value))
            } catch {
                single(.error(error))
            }
        }
    }
    
    
    @discardableResult
    func consigureSession<T: Decodable>(withRequest reuqest: URLRequest, single: @escaping Single<T>.SingleObserver) -> URLSessionTask {
        let dataTask = session.dataTask(with: reuqest, completionHandler: configureSingle(single: single))
        dataTask.resume()
        return dataTask
    }
}
