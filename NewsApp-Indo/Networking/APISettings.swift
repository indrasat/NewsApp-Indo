//
//  APISettings.swift
//  NewsApp-Indo
//
//  Created by Indra Kurniawan on 18/02/23.
//

import Foundation

enum HttpMethod: String {

    case get = "GET"
    case post = "POST"
}

protocol APISetting {

    var httpMethod: HttpMethod { get }
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var parameters: [String: Any] { get }
}

extension APISetting {

    var httpMethod: HttpMethod {
        return .get
    }

    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "newsapi.org"
    }

    var parameters: [String: Any] {
        return [:]
    }

    func createUrlString() -> String {
        return "\(scheme)://\(host)\(path)"
    }
    
    func createUrlRequest() -> URLRequest? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        
        var queryItems: [URLQueryItem] = []

        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            queryItems.append(queryItem)
        }

        let apiKeyItem = URLQueryItem(name: "apiKey", value: "cef8f031bde449a59ddfb6edd27b8b6f")
        queryItems.append(apiKeyItem)
        components.queryItems = queryItems
        
        if let url = components.url {
            return URLRequest(url: url)
        } else {
            return nil
        }
    }
}
