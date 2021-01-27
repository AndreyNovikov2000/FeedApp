//
//  NetworkError.swift
//  FeedApp
//
//  Created by Andrey Novikov on 1/15/21.
//

import Foundation

enum NetworkError: Error {
    case jsonEncodingFailed
    case emptyData
    case urlRequesstIsNil
}
