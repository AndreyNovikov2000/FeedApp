//
//  FeedCell.swift
//  FeedApp
//
//  Created by Andrey Novikov on 1/16/21.
//

import UIKit
import RxDataSources
import RxSwift
import RxCocoa

class FeedCell: UITableViewCell {
    
    // MARK: - Exteranl propeerties
    
    // MARK: - Public properties
    
    var urls = BehaviorRelay<[ImageSectionItem]>(value: [])
    var selectedIndex = BehaviorRelay<IndexPath>.init(value: IndexPath(item: 0, section: 0))
    var animateWebView = PublishRelay<WebImageView>.init()
    static let reusseID = "FeedCell"
    
    // MARK: - Private properties
    
    private let disposeBag = DisposeBag()
    
    private var currentItem: FeedCellViewModelPresentable? {
        didSet {
            collectionView.reloadData()
        }
    }
    
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
    
    let postTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 16)
        textView.isScrollEnabled = false
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
        textView.isEditable = false
        
        
        let padding = textView.textContainer.lineFragmentPadding
        textView.contentInset = UIEdgeInsets(top: 0, left: -padding, bottom: 0, right: -padding)
        textView.dataDetectorTypes = UIDataDetectorTypes.all
        return textView
    }()
    
    let moreTextButtom: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        button.setTitleColor(#colorLiteral(red: 0.3490949869, green: 0.442735225, blue: 1, alpha: 1), for: .normal)
        button.setTitle("Show more...", for: .normal)
        button.contentHorizontalAlignment = .leading
        button.contentVerticalAlignment = .center
        return button
    }()
    
    private lazy var dataSource = RxCollectionViewSectionedReloadDataSource<ImageSectionItem>.init { (_, collectionView, indexPath, item) -> UICollectionViewCell in
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCollectionViewCell.reuseID, for: indexPath) as! FeedCollectionViewCell
        cell.configureImage(withItem: item)
        cell.delegate = self
        return cell
    }
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionView.layout1())
        collectionView.backgroundColor = .clear
        collectionView.register(FeedCollectionViewCell.self, forCellWithReuseIdentifier: FeedCollectionViewCell.reuseID)
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    // MARK: - Object livecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
        setupConstraints()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
       
        imageAvatarView.layer.cornerRadius = imageAvatarView.frame.height / 2
        collectionView.frame = CGRect(origin: CGPoint(x: 0, y: 10 + 50 + 10), size: CGSize(width: contentView.frame.width, height: 200))
    }
    
    override func prepareForReuse() {
        imageAvatarView.set(imageUrl: nil)
        imageAvatarView.image = nil

        super.prepareForReuse()
    }
    
    // MARK: - Insstance methods
    
    func configure(item: FeedCellViewModelPresentable) {
        nameLabel.text = item.title
        dateLabel.text = item.formattedDate
        
        imageAvatarView.set(imageUrl: item.avatarImageUrlString)
        collectionView.collectionViewLayout = UICollectionView.getLayout(count: item.imageUrls?.count ?? 1)
        currentItem = item
            
        let imageCellViewModels = (item.imageUrls?.compactMap({ $0 }).map({ ImageCellViewModel(urlString: $0) }))!
        urls.accept([ImageSectionItem(model: 0, items: imageCellViewModels)])
    }
    
    // MARK: - Private methods
    
    private func setupCell() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
    
    private func setupConstraints() {
        // first layer
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
        bubleView.addSubview(collectionView)
        bubleView.addSubview(collectionView)
        
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
    }
}


// MARK: - Bind

extension FeedCell {
    private func bind() {
        urls.asDriver().drive(collectionView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        collectionView.rx.itemSelected.asDriver().drive(selectedIndex).disposed(by: disposeBag)
    }
}

// MARK: - FeedCollectionViewCellDelegate

extension FeedCell: FeedCollectionViewCellDelegate {
    func feedCollectionViewCellAnimateImageView(_ webImageView: WebImageView) {
        animateWebView.accept(webImageView)
    }
}
