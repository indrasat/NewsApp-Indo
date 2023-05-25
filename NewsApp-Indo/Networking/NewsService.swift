//
//  NewsService.swift
//  NewsApp-Indo
//
//  Created by Indra Kurniawan on 18/02/23.
//

import Foundation
import RxSwift


enum EndPointType: String {
    case topHeadline = "/v2/top-headlines"
}

protocol NewsServiceProtocol {
    
    func fetchTopNews(_ page: Int) -> Observable<TopNewsModel>

}

class NewsService: NewsServiceProtocol {
    
    
    func fetchTopNews(_ page: Int) -> Observable<TopNewsModel> {
        
        return apiRequest(NewsAPI.fetchTopNews(page).createUrlRequest()!)
        
    }
    
    func apiRequest<T: Decodable>(_ urlRequest: URLRequest) -> Observable<T> {
        return Observable<T>.create { observer in
            
            let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in

                if let _ = error {
                    observer.onError(NetworkResponse.badRequest)
                }
                guard let data = data else {
                    observer.onError(NetworkResponse.noData)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    observer.onError(NetworkResponse.badRequest)
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    let news = try decoder.decode(T.self, from: data)
                    observer.onNext(news)
                    observer.onCompleted()
                } catch {
                    observer.onError(NetworkResponse.unableToDecode)
                }
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
