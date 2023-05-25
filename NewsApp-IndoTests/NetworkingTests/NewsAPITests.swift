//
//  NewsAPITests.swift
//  NewsApp-IndoTests
//
//  Created by Indra Kurniawan on 18/02/23.
//

import XCTest
import RxBlocking
@testable import NewsApp_Indivara

class NewsAPITests: XCTestCase {

    var newsAPITopNews: NewsAPI!
    
    override func setUp() {
        newsAPITopNews = NewsAPI.fetchTopNews(4)
    }

    override func tearDown() {
        newsAPITopNews = nil
    }

    func testNewsAPICreatesURLString() {
        
        XCTAssertEqual(newsAPITopNews.createUrlString(), "https://newsapi.org/v2/top-headlines")
    }
    
}
