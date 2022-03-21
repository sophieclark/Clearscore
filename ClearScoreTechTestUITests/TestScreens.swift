//
//  TestScreens.swift
//  ClearScoreTechTestUITests
//
//  Created by Sophie Clark on 21/03/2022.
//

import XCTest

class TestScreens {
    
    // MARK: - Dashboard
    
    func assertSuccessfullDashboardView(in app: XCUIApplication) {
        XCTAssert(app.staticTexts["Dashboard"].exists)
        
        guard app.staticTexts["Your credit score is"].waitForExistence(timeout: 5) else {
            XCTFail("Text doesn't exist \(#file) \(#line)")
            return
        }
        
        XCTAssert(app.staticTexts["Your credit score is"].exists)
        XCTAssert(app.staticTexts["514"].exists)
        XCTAssert(app.staticTexts["out of 700"].exists)
    }
    
    func assertDashboardErrorView(in app: XCUIApplication) {
        XCTAssert(app.staticTexts["Dashboard"].exists)

        guard app.staticTexts["Oops!"].waitForExistence(timeout: 5) else {
            XCTFail("Text doesn't exist \(#file) \(#line)")
            return
        }
        
        XCTAssert(app.staticTexts["Oops!"].exists)
        XCTAssert(app.staticTexts["Something went wrong when loading your credit information."].exists)
        XCTAssert(app.buttons["Retry"].exists)
    }
    
    // MARK: - Credit report
    
    
}
