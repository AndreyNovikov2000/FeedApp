//
//  TrackCellDetal.swift
//  FeedApp
//
//  Created by Andrey Novikov on 1/25/21.
//

import UIKit
import RxSwift
import RxDataSources

class TrackCellDetal: UITableViewCell {
    
    // MARK: - Instance properties
    
    static let reuseID = "TrackCellDetal"
    
    // MARK: - UI
    
    private let trackImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 5
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    private let trackNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 1
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.numberOfLines = 1
        return label
    }()
    
    private let collectionNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.numberOfLines = 1
        return label
    }()
    
    
    // MARK: - Object livecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Instance Methods
    
    func configure(withTrackDetailViewModel model: TrackCellDetailViewModelPresentable) {
        trackImageView.set(imageUrl: model.trackImage)
        
        trackNameLabel.text = model.trackName
        artistNameLabel.text = model.artistName
        collectionNameLabel.text = model.collectionName
    }
    
    // MARK: - Setup
    
    private func setupConstraints() {
        contentView.addSubview(trackImageView)
        contentView.addSubview(trackNameLabel)
        contentView.addSubview(artistNameLabel)
        contentView.addSubview(collectionNameLabel)
        
        // trackImageView
        NSLayoutConstraint.activate([
            trackImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            trackImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            trackImageView.heightAnchor.constraint(equalToConstant: 60),
            trackImageView.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        
        // trackNameLabel
        NSLayoutConstraint.activate([
            trackNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            trackNameLabel.leadingAnchor.constraint(equalTo: trackImageView.trailingAnchor, constant: 16),
            trackNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        
        // artistName
        NSLayoutConstraint.activate([
            artistNameLabel.topAnchor.constraint(equalTo: trackNameLabel.bottomAnchor, constant: 3),
            artistNameLabel.leadingAnchor.constraint(equalTo: trackImageView.trailingAnchor, constant: 16),
            artistNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        
        // collectionName
        NSLayoutConstraint.activate([
            collectionNameLabel.topAnchor.constraint(equalTo: artistNameLabel.bottomAnchor, constant: 3),
            collectionNameLabel.leadingAnchor.constraint(equalTo: trackImageView.trailingAnchor, constant: 16),
            collectionNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
}
