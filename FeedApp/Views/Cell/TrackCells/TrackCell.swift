//
//  TrackCell.swift
//  FeedApp
//
//  Created by Andrey Novikov on 1/25/21.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources


class TrackCell: UITableViewCell {
    
    // MARK: - Instance properties
    
    static let reuseID = "TrackCellCell"
    
    // MARK: - Private properies

    private var trackDetailSectionItem = BehaviorRelay<[TrackCellDetailSection]>.init(value: [])
    private let disposeBag = DisposeBag()
    
    // MARK: - UI
    
    let bubleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        return view
    }()
    
    let imageAvatarView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        imageView.layer.cornerRadius = 50 / 2
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17)
        label.numberOfLines = 1
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 1
        label.textColor = .lightGray
        label.textAlignment = .left
        return label
    }()
    
    // albums
    
    let albumImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var dataSource = RxTableViewSectionedReloadDataSource<TrackCellDetailSection>.init { (_, tableView, indexPath, item) -> UITableViewCell in
        let cell = tableView.dequeueReusableCell(withIdentifier: TrackCellDetal.reuseID, for: indexPath) as! TrackCellDetal
        cell.configure(withTrackDetailViewModel: item)
        return cell
    }
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TrackCellDetal.self, forCellReuseIdentifier: TrackCellDetal.reuseID)
        tableView.backgroundColor = .clear
        tableView.rowHeight = 84
        tableView.isScrollEnabled = false
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    
    // MARK: - Object live cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        binding()
        
        setupConstraints()
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // MARK: - Instance methods
    
    func configure(withTrackCellViewModel model: TrackCellViewModelPresentable) {
        imageAvatarView.set(imageUrl: model.avatarImageUrlString)
        albumImageView.set(imageUrl: model.avatarImageUrlString)
        
        nameLabel.text = model.artistName
        dateLabel.text = "date"
        
        let trackDetailViewModels: [TrackCellDetailViewModel] = model.tracks.map({ TrackCellDetailViewModel(track: $0) })
        trackDetailSectionItem.accept([TrackCellDetailSection(model: 0, items: trackDetailViewModels)])
    }
    
    // MARK: - Private methods
    
    private func setupCell() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
    
    private func setupConstraints() {
        contentView.addSubview(bubleView)
        
        NSLayoutConstraint.activate([
            bubleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            bubleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            bubleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bubleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        // ssecond layer
        bubleView.addSubview(imageAvatarView)
        bubleView.addSubview(nameLabel)
        bubleView.addSubview(dateLabel)
        bubleView.addSubview(albumImageView)
        bubleView.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            imageAvatarView.topAnchor.constraint(equalTo: bubleView.topAnchor, constant: 16),
            imageAvatarView.leadingAnchor.constraint(equalTo: bubleView.leadingAnchor, constant: 16),
            imageAvatarView.heightAnchor.constraint(equalToConstant: 50),
            imageAvatarView.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: bubleView.topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: imageAvatarView.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: bubleView.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            dateLabel.leadingAnchor.constraint(equalTo: imageAvatarView.trailingAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(equalTo: bubleView.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            albumImageView.topAnchor.constraint(equalTo: imageAvatarView.bottomAnchor, constant: 10),
            albumImageView.leadingAnchor.constraint(equalTo: bubleView.leadingAnchor, constant: 1),
            albumImageView.trailingAnchor.constraint(equalTo: bubleView.trailingAnchor, constant: -1),
            albumImageView.heightAnchor.constraint(equalToConstant: K.FeedSizes.layout1Size)
        ])

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: albumImageView.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: bubleView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: bubleView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bubleView.bottomAnchor, constant: -10),
        ])
    }
}


// MARK: - Binding

extension TrackCell {
    private func binding() {
        trackDetailSectionItem.asDriver().drive(tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
    }
}
