//
//  TopNewsModel.swift
//  NewsApp-Indo
//
//  Created by Indra Kurniawan on 18/02/23.
//

import Foundation

struct TopNewsModel: Codable {
    let status: String
    let totalResults: Int
    let articles: [TopNewsArticleModel]
}
