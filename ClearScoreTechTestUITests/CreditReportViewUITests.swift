//
//  CreditReportViewUITests.swift
//  ClearScoreTechTestUITests
//
//  Created by Sophie Clark on 21/03/2022.
//

import XCTest

class CreditReportViewUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
    }

    func testCreditReportView_withShortTermDebtOnly() {
        app.launchEnvironment = ["jsonToLoad":"mockcredit-values-onlyshorttermdebt"]
        getToCreditReport()
        XCTAssert(app.staticTexts["Changes"].exists)
        XCTAssert(app.staticTexts["Your short term debt is £13758"].exists)
        XCTAssert(app.staticTexts["Your short term debt has increased by £549"].exists)
        XCTAssertFalse(app.staticTexts["Your long term debt is £24682"].exists)
        XCTAssertFalse(app.staticTexts["Your long term debt has decreased by £-327"].exists)
        XCTAssert(app.staticTexts["Insights"].exists)
        XCTAssert(app.staticTexts["You have no missed payments on file"].exists)
        XCTAssert(app.staticTexts["You have no defaults on file"].exists)
    }
    
    func testCreditReportView_withLongTermDebtOnly() {
        app.launchEnvironment = ["jsonToLoad":"mockcredit-values-onlylongtermdebt"]
        getToCreditReport()
        XCTAssert(app.staticTexts["Changes"].exists)
        XCTAssertFalse(app.staticTexts["Your short term debt is £13758"].exists)
        XCTAssertFalse(app.staticTexts["Your short term debt has increased by £549"].exists)
        XCTAssert(app.staticTexts["Your long term debt is £24682"].exists)
        XCTAssert(app.staticTexts["Your long term debt has decreased by £-327"].exists)
        XCTAssert(app.staticTexts["Insights"].exists)
        XCTAssert(app.staticTexts["You have no missed payments on file"].exists)
        XCTAssert(app.staticTexts["You have no defaults on file"].exists)
    }
    
    func testCreditReportView_withShortAndLongTermDebt() {
        app.launchEnvironment = ["jsonToLoad":"mockcredit-values-shortlongtermdebt"]
        getToCreditReport()
        XCTAssert(app.staticTexts["Changes"].exists)
        XCTAssert(app.staticTexts["Your short term debt is £13758"].exists)
        XCTAssert(app.staticTexts["Your short term debt has increased by £549"].exists)
        XCTAssert(app.staticTexts["Your long term debt is £24682"].exists)
        XCTAssert(app.staticTexts["Your long term debt has decreased by £-327"].exists)
        XCTAssert(app.staticTexts["Insights"].exists)
        XCTAssert(app.staticTexts["You have no missed payments on file"].exists)
        XCTAssert(app.staticTexts["You have no defaults on file"].exists)
    }
    
    func testCreditReportView_withMissedAndDefualtedPayments_oneMonthAgo() {
        app.launchEnvironment = ["jsonToLoad":"mockcredit-values-missedanddefaultedonemonth"]
        getToCreditReport()
        XCTAssert(app.staticTexts["Insights"].exists)
        XCTAssert(app.staticTexts["You last missed a payment 1 month ago"].exists)
        XCTAssert(app.staticTexts["You last defaulted 1 month ago"].exists)
    }
    
    func testCreditReportView_withMissedAndDefualtedPayments_tenMonthsAgo() {
        app.launchEnvironment = ["jsonToLoad":"mockcredit-values-missedanddefaultedtenmonths"]
        getToCreditReport()
        XCTAssert(app.staticTexts["Insights"].exists)
        XCTAssert(app.staticTexts["You last missed a payment 10 months ago"].exists)
        XCTAssert(app.staticTexts["You last defaulted 10 months ago"].exists)
    }
    
    func testTappingBack_showsDashboard() {
        getToCreditReport()
        app.buttons["Dashboard"].tap()
        TestScreens().assertSuccessfullDashboardView(in: app)
    }
    
    private func getToCreditReport() {
        app.launchArguments = ["-launchWithSuccess"]
        app.launch()
        TestScreens().assertSuccessfullDashboardView(in: app)
        
        // tap score view
        app.staticTexts["514"].tap()
        
        XCTAssert(app.staticTexts["Credit report"].exists)
        XCTAssert(app.staticTexts["514"].exists)
        XCTAssert(app.staticTexts["out of 700"].exists)
        XCTAssert(app.buttons["Dashboard"].exists)
    }
}
