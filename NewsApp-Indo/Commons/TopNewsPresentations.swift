//
//  TopNewsPresentations.swift
//  NewsApp-Indo
//
//  Created by Indra Kurniawan on 18/02/23.
//

import Foundation
import RxDataSources

final class TopNewsPresentation {
    let source: String
    let author: String?
    let title: String
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
    
    init(source: String, author: String?, title: String, url: String, urlToImage: String?, publishedAt: String, content: String?) {
        self.source = source
        self.author = author
        self.title = title
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
    }
    convenience init(topHeadline: TopNewsArticleModel) {
        self.init(source: topHeadline.source.name, author: topHeadline.author, title: topHeadline.title, url: topHeadline.url, urlToImage: topHeadline.urlToImage, publishedAt: topHeadline.publishedAt, content: topHeadline.content)
    }
}

extension TopNewsPresentation: Equatable {
    static func == (lhs: TopNewsPresentation, rhs: TopNewsPresentation) -> Bool {
        return lhs.author == rhs.author && lhs.source == rhs.source && lhs.publishedAt == rhs.publishedAt && lhs.title == rhs.title && lhs.url == rhs.url && lhs.urlToImage == rhs.urlToImage && lhs.content == rhs.content

    }
    
    
}

struct TopNewsPresentationSection {
    var items: [TopNewsPresentation]
}

extension TopNewsPresentationSection: SectionModelType {
    init(original: TopNewsPresentationSection, items: [TopNewsPresentation]) {
        self = original
        self.items = items
    }
}
