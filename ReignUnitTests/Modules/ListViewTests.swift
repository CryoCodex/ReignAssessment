//
//  ListViewTests.swift
//  ReignUnitTests
//
//  Created by Neptali Duque on 4/6/21.
//

import XCTest
@testable import Reign

class ListViewTests: XCTestCase {
    
    // MARK: - Presenter Tests
    func testRealNewsTitle() throws {
        let news = News()
        news.story_title = "Title"
        news.title = nil
    
        XCTAssertTrue(news.story_title != nil || news.title != nil)
        
        news.story_title = nil
        news.title = "News"
        
        XCTAssertTrue(news.story_title != nil || news.title != nil)
        
        news.story_title = nil
        news.title = nil
        
        XCTAssertFalse(news.story_title != nil || news.title != nil)
    }
    
    func testRealUrl() throws {
        let news = News()
        news.story_url = "https://www.google.com"
        news.url = nil
    
        XCTAssertTrue(news.story_url != nil || news.url != nil)
        
        news.story_url = nil
        news.url = "https://www.google.com"
        
        XCTAssertTrue(news.story_url != nil || news.url != nil)
        
        news.story_url = nil
        news.url = nil
        
        XCTAssertFalse(news.story_url != nil || news.url != nil)
    }

}
