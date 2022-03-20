//
//  DashboardViewUITests.swift
//  ClearScoreTechTestUITests
//
//  Created by Sophie Clark on 19/03/2022.
//

import XCTest
@testable import ClearScoreTechTest

class DashboardViewUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
    }

    func testDashboardViewSuccess() throws {
        app.launchArguments = ["-launchWithSuccess"]
        app.launch()
        XCTAssert(app.staticTexts["Dashboard"].exists)
        
        guard app.staticTexts["Your credit score is"].waitForExistence(timeout: 5) else {
            XCTFail("Text doesn't exist \(#file) \(#line)")
            return
        }
        
        XCTAssert(app.staticTexts["Your credit score is"].exists)
        XCTAssert(app.staticTexts["514"].exists)
        XCTAssert(app.staticTexts["out of 700"].exists)
    }

    func testDashboardViewFailure() throws {
        app.launchArguments = ["-launchWithFailure"]
        app.launch()
        XCTAssert(app.staticTexts["Dashboard"].exists)

        guard app.staticTexts["Oops!"].waitForExistence(timeout: 5) else {
            XCTFail("Text doesn't exist \(#file) \(#line)")
            return
        }
        
        XCTAssert(app.staticTexts["Oops!"].exists)
        XCTAssert(app.staticTexts["Something went wrong when loading your credit information."].exists)
        XCTAssert(app.buttons["Retry"].exists)
    }
}
