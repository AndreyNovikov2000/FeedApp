//
//  UIViewController + extention.swift
//  FeedApp
//
//  Created by Andrey Novikov on 1/16/21.
//

import UIKit

extension UIViewController {
    static func loadFromXib<T: UIViewController>() -> T {
        guard let viewController = UINib(nibName: String(describing: T.self), bundle: nil).instantiate(withOwner: nil, options: nil).first as? T else {
            fatalError("xib file: \(String(describing: T.self)) not exist")
        }
        
        return viewController
    }
}
