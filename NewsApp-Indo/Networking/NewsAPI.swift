//
//  NewsAPI.swift
//  NewsApp-Indo
//
//  Created by Indra Kurniawan on 18/02/23.
//

import Foundation

enum NewsAPI {
    case fetchTopNews(_ page: Int)
}

extension NewsAPI: APISetting {
    var path: String {
        switch self {
        case .fetchTopNews(_):
            return EndPointType.topHeadline.rawValue
        }
    }
    
    var parameters: [String : Any] {
        switch self {
        case .fetchTopNews(let page):
            return ["country" : "id", "pageSize": 10, "page": page]
        }
    }
    
    
}
