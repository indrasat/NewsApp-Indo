//
//  MockNewsService.swift
//  NewsApp-IndoTests
//
//  Created by Indra Kurniawan on 18/02/23.
//

import Foundation
import RxSwift

@testable import NewsApp_Indivara

class MockNewsService: NewsServiceProtocol {
    
    var topNews: TopNewsModel?
    let urlReq: URLRequest = URLRequest(url: URL(string: "fakeURL")!)
    
    func fetchTopNews(_ page: Int) -> Observable<TopNewsModel> {
        return apiRequestTop(urlReq)
    }
    
    
    func apiRequestTop(_ urlRequest: URLRequest) -> Observable<TopNewsModel> {
        return Observable<TopNewsModel>.create {
            observer in
            observer.onNext(self.topNews!)
            observer.onCompleted()
            return Disposables.create {
            }
        }
    }
    
}
