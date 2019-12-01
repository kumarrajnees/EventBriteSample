//
//  EventBriteSampleTests.swift
//  EventBriteSampleTests
//
//  Created by Rajneesh Kumar on 12/1/19.
//  Copyright © 2019 Rajneesh Kumar. All rights reserved.
//

import XCTest
@testable import EventBriteSample

class EventBriteSampleTests: XCTestCase {
    var dateStrTotest: String!
    var mockDate: Date!
    var dateFormat: GFDateFormat!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockDate = Date()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        dateStrTotest = nil
        mockDate = nil
        dateFormat = nil
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testValidOutput() {
        // 1. given
        dateStrTotest = "2018-02-05 09:40:49" //2019-02-04 09:40:49
        dateFormat = GFDateFormat.yyyyMMddHHmmss
        // 2. when
        let timeAgo = mockDate.timeAgo(from: dateStrTotest, dateFormat: dateFormat)
        // 3. then
        XCTAssertEqual(timeAgo, "1 year ago", "Time ago should be 1 year ago getting wrong")
    }
//    func testSameTime() {
//        // 1. given
//        dateStrTotest = "2018-02-05 17:31:49" //2019-02-04 09:40:49
//        dateFormat = GFDateFormat.yyyyMMddHHmmss
//        // 2. when
//        let timeAgo = mockDate.timeAgo(from: dateStrTotest, dateFormat: dateFormat)
//        // 3. then
//        XCTAssertEqual(timeAgo, "11 months ago", "Time ago should be 11 months ago getting wrong")
//    }

}
