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

    func testDahsboardView() throws {
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

}
