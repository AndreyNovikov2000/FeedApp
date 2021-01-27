//
//  FeedCollectionViewCell.swift
//  FeedApp
//
//  Created by Andrey Novikov on 1/25/21.
//

import UIKit


protocol FeedCollectionViewCellDelegate: class {
    func feedCollectionViewCellAnimateImageView(_ webImageView: WebImageView)
}

class FeedCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Instance methods
    
    static let reuseID = "ImageCollectionViewCell"
    weak var delegate: FeedCollectionViewCellDelegate?
    
    // MARK: - UI
    
    
    let imageView: WebImageView = {
        let imageView = WebImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    
    // MARK: - Object livecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        contentView.clipsToBounds = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.frame
    }
    
    override func prepareForReuse() {
        imageView.set(imageUrl: nil)
        imageView.image = nil
        
        super.prepareForReuse()
    }
    
    // MARK: - Instance methods
    
    func configureImage(withItem item: ImageCellViewModelPresentable) {
        imageView.set(imageUrl: item.urlString)
    }
    
    @objc private func handleTap() {
        delegate?.feedCollectionViewCellAnimateImageView(imageView)
    }
}

