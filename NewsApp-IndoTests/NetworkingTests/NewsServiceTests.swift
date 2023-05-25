//
//  NewsServiceTests.swift
//  NewsApp-IndoTests
//
//  Created by Indra Kurniawan on 18/02/23.
//

import XCTest

@testable import NewsApp_Indivara

class NewsServiceTests: XCTestCase {

    func testParsing() throws {
        let bundle = Bundle(for: NewsServiceTests.self)
        let url = bundle.url(forResource: "fetchTopNews", withExtension: "json")
        let data = try Data(contentsOf: url!)
        let decoder = JSONDecoder()
        let fetchNews = try decoder.decode(TopNewsModel.self, from: data)
        
        XCTAssertEqual(fetchNews.status, "ok")
        XCTAssertEqual(fetchNews.totalResults, 38)
        XCTAssertEqual(fetchNews.articles.count, 2)
        
    }
    
}
