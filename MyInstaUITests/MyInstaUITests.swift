//
//  MyInstaUITests.swift
//  MyInstaUITests
//
//  Created by Jeslin Johnson on 21/03/2025.
//

import XCTest

final class MyInstaUITests: XCTestCase {

    var app: XCUIApplication!
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["UITesting"]
        app.launch()
    }

    func testDisplayPosts() {
        XCTAssertTrue(app.staticTexts["Post 1"].exists)
        XCTAssertTrue(app.staticTexts["Post 2"].exists)
    }

    func testRefreshPosts() {
        app.swipeDown()
        XCTAssertTrue(app.staticTexts["Post 1"].exists)
        XCTAssertTrue(app.staticTexts["Post 2"].exists)
    }

    func testErrorHandling() {
        app.launchArguments = ["UITesting", "SimulateError"]
        app.launch()
        
        XCTAssertTrue(app.alerts["Error"].exists)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
