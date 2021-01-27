//
//  WebImageView.swift
//  FeedApp
//
//  Created by Andrey Novikov on 1/24/21.
//

import UIKit
import RxCocoa

class WebImageView: UIImageView {
    
    var imageSet = BehaviorRelay<UIImage?>.init(value: nil)
    
    private var currentUrlString: String?
    
    func set(imageUrl: String?) {
        
        currentUrlString = imageUrl
        
        guard let imageUrl = imageUrl, let url = URL(string: imageUrl) else {
            self.image = nil
            return
        }
        
        if let caceResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            let imageData = UIImage(data: caceResponse.data)
            image = imageData
            imageSet.accept(imageData)
            return
        }
        
        let sessionDataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if let error = error {
                print("Fail to load image, error = \(error)")
                return
            }
            guard let data = data, let response = response else { return }
            DispatchQueue.main.async {
                self?.handleLoadedImage(data: data, response: response)
            }
        }
        sessionDataTask.resume()
    }
    
    // MARK: - Private
    private func handleLoadedImage(data: Data, response: URLResponse) {
        guard let responseUrl = response.url else { return }
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseUrl))
        
        if response.url?.absoluteString == currentUrlString {
            let imageData = UIImage(data: data)
            self.image = imageData
            imageSet.accept(imageData)
        }
    }
}

