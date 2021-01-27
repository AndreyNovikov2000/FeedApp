  //
  //  ViewController.swift
  //  FeedApp
  //
  //  Created by Andrey Novikov on 1/14/21.
  //
  
  import UIKit
  import RxSwift
  import RxCocoa
  import RxDataSources
  
  class FeedViewController: UIViewController {
    
    // MARK: - Public properties
    
    var builder: FeedViewModelRepresentable.Builder!
    
    // MARK: - Private properties
    
    private var feedViewModel: FeedViewModelRepresentable!
    private var didScroll: BehaviorRelay<CGPoint> = BehaviorRelay<CGPoint>(value: .zero)
    private let disposeBag = DisposeBag()
    
    private lazy var dataSource = RxTableViewSectionedReloadDataSource<FeedSectionItem>.init { (_, tableView, indexPath, item) -> UITableViewCell in
        switch item.feedType {
        case .imageContentType:
            let cell = tableView.dequeueReusableCell(withIdentifier: FeedCell.reusseID, for: indexPath) as! FeedCell
            cell.configure(item: item)
            self.sparkingScrollView.removeFromSuperview()
            cell.animateWebView.subscribe { (event) in
                guard let imageView = event.element else { return }
                self.animateIn(imageView)
            }.disposed(by: self.disposeBag)
            
            return cell
        case .trackType:
            return UITableViewCell()
        }
    }
    
    // MARK: - UI
    
    private var sparkingScrollView: SparkingScrollView!
    private let tableView = UITableView()
    private let refreshControl = UIRefreshControl()
    
    // Animation elements
    
    private var initinalImageView: WebImageView?
    private var animationImageView: WebImageView?
    private var backgroundBlackView: UIView?
    
    
    // MARK: - Object livecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        binding()
        setupTableView()
        setupSparkScrollView()
    }
    
    // MARK: - Slector methods
    
    @objc private func handleAnimateOut(gesture: UIPanGestureRecognizer) {
        guard let animationImageView = animationImageView, let backgroundBlackView = backgroundBlackView else { return }
        let translation = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)
        
        switch gesture.state {
        case .changed:
            translationAnimation(translation: translation)
        case .ended:
            
            
            if abs(translation.y) > animationImageView.frame.height * 2 / 3 || abs(velocity.x) > 700 || abs(velocity.y) > 700 {
                animateOut()
            } else {
                UIView.animate(withDuration: 0.3) {
                    backgroundBlackView.alpha = 1
                    animationImageView.transform = .identity
                    self.tabBarController?.tabBar.alpha = 0
                }
            }
        default: break
        }
    }
    
    
    // MARK: - SetupUI
    
    private func setupTableView() {
        tableView.frame = view.bounds
        tableView.tableFooterView = UIView()
        tableView.register(FeedCell.self, forCellReuseIdentifier: FeedCell.reusseID)
        tableView.rowHeight = 300
        tableView.separatorStyle = .none
        tableView.backgroundColor = .backgroundWhite
        tableView.refreshControl = refreshControl
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        view.addSubview(tableView)
    }
    
    private func setupSparkScrollView() {
        sparkingScrollView = SparkingScrollView(frame: view.bounds)
        view.addSubview(sparkingScrollView)
    }
  }
  
  
  // MARK: - Binding
  
  extension FeedViewController {
    private func binding() {
        let isRefreshing = refreshControl.rx.isRefreshing.asObserver()
        let controlUpdate = refreshControl.rx.controlEvent(.valueChanged).asDriver()
        
        let input =  (isRefreshing: isRefreshing, controlUpdate: controlUpdate, ())
        feedViewModel = builder(input)
        feedViewModel.output.news.drive(tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
    }
  }
  
  
  // MARK: - UITableViewDelegate
  
  extension FeedViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
  }
  
  
  // MARK: - Animation
  
  extension FeedViewController {
    private func animateIn(_ initinalWebImageView: WebImageView) {
        guard backgroundBlackView == nil && animationImageView == nil else { return }
        guard let startFrame = initinalWebImageView.superview?.convert(initinalWebImageView.frame, to: nil) else { return }
        initinalWebImageView.isHidden = true
        self.initinalImageView = initinalWebImageView
        
        backgroundBlackView = UIView()
        if let backgroundBlackView = backgroundBlackView {
            backgroundBlackView.backgroundColor = .black
            backgroundBlackView.frame = UIScreen.main.bounds
            backgroundBlackView.alpha = 0
            view.addSubview(backgroundBlackView)
        }
        
        animationImageView = WebImageView()
        if let animationImageView = animationImageView {
            initinalImageView?.imageSet.subscribe({ (event) in
                guard let image = event.element else { return }
                animationImageView.image = image
            }).disposed(by: disposeBag)
            animationImageView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
            animationImageView.frame = startFrame
            animationImageView.contentMode = .scaleAspectFill
            animationImageView.clipsToBounds = true
            animationImageView.isUserInteractionEnabled = true
            animationImageView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleAnimateOut)))
            view.addSubview(animationImageView)
        }
        
        
        let height = (view.frame.size.width / startFrame.width) * startFrame.height
        let y = view.frame.height / 2 - startFrame.height / 2
        
        UIView.animate(withDuration: 0.4) {
            self.backgroundBlackView?.alpha = 1
            self.animationImageView?.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: height)
            self.tabBarController?.tabBar.alpha = 0
        }
    }
    
    private func translationAnimation(translation: CGPoint) {
        guard let animationImageView = animationImageView, let backgroundBlackView = backgroundBlackView else { return }
        var alpha = abs((animationImageView.frame.height - abs(translation.y)) /  animationImageView.frame.height)
        if abs(translation.y) > animationImageView.frame.height  {
            alpha = 0
        }
        let tabBarAlpha = 1 - alpha
        
        backgroundBlackView.alpha = alpha
        animationImageView.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
        tabBarController?.tabBar.alpha = tabBarAlpha
    }
    
    
    
    private func animateOut() {
        guard let backgroundBlackView = backgroundBlackView, let animationImageView = animationImageView, let initinalImageView = initinalImageView else { return }
        guard let startFrame = initinalImageView.superview?.convert(initinalImageView.frame, to: nil)  else { return }
        
        UIView.animate(withDuration: 0.4, animations: {
            backgroundBlackView.alpha = 0
            animationImageView.frame = startFrame
            self.tabBarController?.tabBar.alpha = 1
        }) { _ in
            self.backgroundBlackView?.removeFromSuperview()
            self.animationImageView?.removeFromSuperview()
            self.backgroundBlackView = nil
            self.animationImageView = nil
            initinalImageView.isHidden = false
        }
    }
  }
