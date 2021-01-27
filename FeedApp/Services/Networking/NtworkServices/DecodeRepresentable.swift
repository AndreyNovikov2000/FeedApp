//
//  Parselable.swift
//  FeedApp
//
//  Created by Andrey Novikov on 1/15/21.
//

import Foundation

protocol DecodeRepresentable {
    func decode<T: Decodable>(data: Data) throws -> T
}

extension DecodeRepresentable {
    func decode<T: Decodable>(data: Data) throws -> T {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}
