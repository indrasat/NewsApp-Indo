//
//  TopNewsArticleModel.swift
//  NewsApp-Indo
//
//  Created by Indra Kurniawan on 18/02/23.
//

import Foundation

struct TopNewsArticleModel: Codable {
    let source: TopNewsSourceModel
    let author: String?
    let title: String
    let articleDescription: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?

    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
}
