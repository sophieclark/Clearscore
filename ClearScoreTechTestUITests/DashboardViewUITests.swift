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
        TestScreens().assertSuccessfullDashboardView(in: app)
    }

    func testDashboardViewFailure() throws {
        app.launchArguments = ["-launchWithFailure"]
        app.launch()
        TestScreens().assertDashboardErrorView(in: app)
    }
    
    func testDashboardViewSuccess_tappingScoreView_opensCreditReport() throws {
        app.launchArguments = ["-launchWithSuccess"]
        app.launch()
        TestScreens().assertSuccessfullDashboardView(in: app)
        
        // tap score view
        app.staticTexts["514"].tap()
        
        XCTAssertFalse(app.staticTexts["Dashboard"].exists)
        XCTAssert(app.staticTexts["Credit report"].exists)
    }

    func testDashboardViewFailure_tappingErrorView_doesntOpenCreditReport() throws {
        app.launchArguments = ["-launchWithFailure"]
        app.launch()
        TestScreens().assertDashboardErrorView(in: app)
        
        app.staticTexts["Oops!"].tap()
        
        XCTAssert(app.staticTexts["Dashboard"].exists)
    }
}
