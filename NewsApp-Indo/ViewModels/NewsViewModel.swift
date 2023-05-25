//
//  NewsViewModel.swift
//  NewsApp-Indo
//
//  Created by Indra Kurniawan on 18/02/23.
//

import Foundation
import RxSwift

final class NewsViewModel {
    
    var service: NewsServiceProtocol
    var page = 2
    let news: BehaviorSubject<[TopNewsPresentation]> = .init(value: [])
    
    let loading: Observable<Bool>
    var loadPageTrigger: PublishSubject<Void>
    var loadNextPageTrigger: PublishSubject<Void>
    let disposeBag = DisposeBag()
    var loadingIndicator: ActivityIndicator!
        
    private let error = PublishSubject<Swift.Error>()
    
    init(_ service: NewsServiceProtocol) {
        loadingIndicator = ActivityIndicator()
        loading = loadingIndicator.asObservable()
        loadPageTrigger = PublishSubject()
        loadNextPageTrigger = PublishSubject()
        self.service = service
        load()
    }

    func load() {

        dataObserver.subscribe(onNext: {
            print("refresh data NewsViewModel")
            }).disposed(by: disposeBag)
        
        let loadRequest = self.loading
            .sample(self.loadPageTrigger)
            .flatMap { [weak self] loading -> Observable<[TopNewsPresentation]> in
                guard let self = self else { fatalError() }
                if loading {
                    return Observable.empty()
                } else {
                    self.page = 2
                    self.news.onNext([])
                    let news = self.service.fetchTopNews(self.page).map({
                        items in items.articles
                    })
                    let mappedNews = news.map({
                        items in items.map({
                            item in TopNewsPresentation.init(topHeadline: item)
                        })
                    })
                    return mappedNews
                        .trackActivity(self.loadingIndicator)
                }
        }

        let nextRequest = self.loading
            .sample(loadNextPageTrigger)
            .flatMap { [weak self] isLoading -> Observable<[TopNewsPresentation]> in
                guard let self = self else { fatalError() }
                if isLoading {
                    return Observable.empty()
                } else {
                    self.page = self.page + 1
                    let news = self.service.fetchTopNews(self.page).map({
                        items in items.articles
                    })
                    let mappedNews = news.map({
                        items in items.map({
                            item in TopNewsPresentation.init(topHeadline: item)
                        })
                    })
                    return mappedNews
                        .trackActivity(self.loadingIndicator)
                }
        }
        let request = Observable.of(loadRequest, nextRequest)
            .merge()
            .share(replay: 1)

        let response = request
            .flatMapLatest { news -> Observable<[TopNewsPresentation]> in
            request
                .do(onError: { _error in
                    self.error.onNext(_error)
                }).catchError({ error ->
                    Observable<[TopNewsPresentation]> in
                    Observable.empty()
                    
                })
            }
        .share(replay: 1)
        
        Observable
            .combineLatest(request, response , news.asObservable()) { request, response, news in
                return self.page == 2 ? response : news + response
        }
        .sample(response)
        .bind(to: news)
        .disposed(by: disposeBag)
    }
    
    
}
