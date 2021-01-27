//
//  String+extention.swift
//  FeedApp
//
//  Created by Andrey Novikov on 1/15/21.
//

import Foundation

extension String {
    func asURL() throws -> URL {
        guard let url =  URL(string: self) else {
            throw NSError(domain: "Wrong url string, url string: \(self)", code: -1, userInfo: [:])
        }
        
        return url
    }
}
