//
//  ResourceLoader.swift
//  NewsApp-IndoTests
//
//  Created by Indra Kurniawan on 18/02/23.
//

import Foundation
@testable import NewsApp_Indivara

class ResourceLoader {
    
    enum NewsResource: String {
        case fetchTopNews
    }
    
    
    static func loadTopNews(resource: NewsResource) throws -> TopNewsModel {
        return try loadNews(resource: resource)
    }
    
    
    static func loadNews<T: Decodable>(resource: NewsResource) throws -> T {
        
        let bundle = Bundle(for: ResourceLoader.self)
        let url = bundle.url(forResource: resource.rawValue, withExtension: "json")
        let data = try Data(contentsOf: url!)
        let decoder = JSONDecoder()
        let fetchNews = try decoder.decode(T.self, from: data)
        
        return fetchNews
    }
}
