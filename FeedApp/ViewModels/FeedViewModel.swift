//
//  FeedViewModel.swift
//  FeedApp
//
//  Created by Andrey Novikov on 1/14/21.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa

protocol FeedViewModelRepresentable {
    typealias Input = (isRefreshing: AnyObserver<Bool>, controlUpdate: Driver<Void>, ())
    typealias Output = (news: Driver<[FeedSectionItem]>, ())
    typealias Builder = (Input) -> FeedViewModelRepresentable
    typealias State = (news: BehaviorRelay<[NewsWrapped]>, ())
    typealias ServicesAPI = (newsService: NewsAPI, imageService: ImageUnsplashAPI, itunesService: ITunesAPI)
    
    var input: FeedViewModelRepresentable.Input { get set }
    var output: FeedViewModelRepresentable.Output { get set }
}

final class FeedViewModel: FeedViewModelRepresentable {
    var input: (isRefreshing: AnyObserver<Bool>, controlUpdate: Driver<Void>, ())
    var output: (news: Driver<[FeedSectionItem]>, ())
    let disposeBag = DisposeBag()

    private let newsContentManager = NewsContentManager()
    private let services: FeedViewModelRepresentable.ServicesAPI
    
    private let page = BehaviorSubject<Int>(value: 1)
    private var state: FeedViewModelRepresentable.State = (news: BehaviorRelay(value: []), ())
    
    init(input: FeedViewModelRepresentable.Input, services: FeedViewModelRepresentable.ServicesAPI) {
        self.input = input
        self.output = FeedViewModel.output(input: input, state: state)
        self.services = services
        
        process()
        update()
    }
}


extension FeedViewModel {
    static func output(input: FeedViewModelRepresentable.Input, state: FeedViewModelRepresentable.State) -> FeedViewModelRepresentable.Output {
        
        let news = state.news
            .asObservable()
            .subscribeOn(MainScheduler.instance)
            .map({ [FeedSectionItem(model: 0, items: $0.compactMap({ FeedCellViewModel(news: $0) }))] })
            .asDriver(onErrorJustReturn: [])
        
        return (news: news, ())
    }
    
    func process() {
        (0...5).forEach { _ in
            start()
            page.on(.next(((try? page.value()) ?? 1) + 1))
        }
    }
    
    private func start() {
        let newsObservable = services.newsService.fetchTopBusiness(country: .us, categoty: .random()).asObservable()
        let imageObservable = services.imageService.fetchImages(withPage: (try? page.value()) ?? 1).asObservable()
        let iTunesObservable = services.itunesService.getContent(authorName: newsContentManager.getAuthorName(), entity: .none).asObservable()
        var content: [NewsWrapped] = []
        
        Observable.combineLatest(newsObservable, imageObservable, iTunesObservable).map { (news, images, itunes)  in
            let feedType = self.newsContentManager.getFeedType()
            
            
            switch feedType {
            case .imageContentType:
                var unsplashImages = images
                var urls = [String]()
                let imagesCount =  Int.random(in: 1...4)
                
                for value in zip(1...imagesCount, unsplashImages) {
                    let imageURL = value.1.urls.small
                    urls.append(imageURL)
                    unsplashImages.removeAll(where: { $0.urls.small == imageURL })
                }
                
                
            
                let combined = zip(news.articles, images)
                for value in combined {
                    let post = NewsWrapped(title: value.0.author ?? "No Name",
                                          date: value.0.publishedAt ?? "",
                                          avatarImageUrlString: value.0.urlToImage ?? "",
                                          id: UUID().uuidString,
                                          feedType: .imageContentType,
                                          bodyTitle: value.0.title,
                                          imageUrls: urls,
                                          tracks: nil)
                    content.append(post)
                }
                
            case .trackType:
                break
                // TODO: Track cell
                var tracksResult = [Track]()
                itunes.results.forEach { (track) in
                    let newTrack = Track(artistName: track.artistName,
                                         trackName: track.trackName ?? "",
                                         trackImage: track.artworkUrl30 ?? "",
                                         trackUrl: track.previewUrl ?? "")
                    if tracksResult.count < 7 {
                        tracksResult.append(newTrack)
                    }
                }
                let post = NewsWrapped(title: "", date: "", avatarImageUrlString: "", id: "", feedType: .trackType, bodyTitle: nil, imageUrls: nil, tracks: tracksResult)
                content.append(post)
            }
            
            var totalContent = (self.state.news.value) + content
            totalContent = totalContent.shuffled()
            self.state.news.accept(totalContent)
        }.subscribe({ (event) in
            switch event {
            case .next():
                self.input.isRefreshing.on(.next(true))
            case .error(_), .completed:
                self.input.isRefreshing.on(.next(false))
            }
        })
        .disposed(by: disposeBag)
    }
    
    private func update() {
        input.controlUpdate.asObservable().subscribe { _ in
            self.process()
        }.disposed(by: disposeBag)
    }
}
