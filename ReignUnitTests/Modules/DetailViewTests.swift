//
//  DetailViewTests.swift
//  ReignUnitTests
//
//  Created by Neptali Duque on 4/7/21.
//

import XCTest
@testable import Reign

class DetailViewTests: XCTestCase {
    
    func testStringUrl() throws {
        let stringUrl = "https://www.youtube.com"
        let url = URL(string: stringUrl)
        XCTAssertNotNil(url)
    }
}
