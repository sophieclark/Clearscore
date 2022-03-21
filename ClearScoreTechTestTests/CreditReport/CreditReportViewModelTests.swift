//
//  CreditReportViewModelTests.swift
//  ClearScoreTechTestTests
//
//  Created by Sophie Clark on 21/03/2022.
//

import XCTest
@testable import ClearScoreTechTest

class CreditReportViewModelTests: XCTestCase {

    func test_getShortTermDebtChange_returnsCorrectValue() {
        let creditAccountIncrease = MockCreditAccount.makeCreditAccount(changeInShortTermDebt: 100)
        XCTAssertEqual(CreditReportViewModel.getShortTermDebtChange(from: creditAccountIncrease), "Your short term debt has increased by")
        let creditAccountDecrease = MockCreditAccount.makeCreditAccount(changeInShortTermDebt: -100)
        XCTAssertEqual(CreditReportViewModel.getShortTermDebtChange(from: creditAccountDecrease), "Your short term debt has decreased by")
        let creditAccountNoChange = MockCreditAccount.makeCreditAccount(changeInShortTermDebt: 0)
        XCTAssertEqual(CreditReportViewModel.getShortTermDebtChange(from: creditAccountNoChange), "Your short term debt has stayed the same")
    }
    
    func test_getLongTermDebtChange_returnsCorrectValue() {
        let creditAccountIncrease = MockCreditAccount.makeCreditAccount(changeInLongTermDebt: 100)
        XCTAssertEqual(CreditReportViewModel.getLongTermDebtChange(from: creditAccountIncrease), "Your long term debt has increased by")
        let creditAccountDecrease = MockCreditAccount.makeCreditAccount(changeInLongTermDebt: -100)
        XCTAssertEqual(CreditReportViewModel.getLongTermDebtChange(from: creditAccountDecrease), "Your long term debt has decreased by")
        let creditAccountNoChange = MockCreditAccount.makeCreditAccount(changeInLongTermDebt: 0)
        XCTAssertEqual(CreditReportViewModel.getLongTermDebtChange(from: creditAccountNoChange), "Your long term debt has stayed the same")
    }
    
    func test_getDefaultedText_returnsCorrectValue() {
        let creditAccountDefaultedOneMonth = MockCreditAccount.makeCreditAccount(hasEverDefaulted: true, monthsSinceLastDefaulted: 1)
        XCTAssertEqual(CreditReportViewModel.getDefaultedText(from: creditAccountDefaultedOneMonth), "You last defaulted 1 month ago")
        let creditAccountDefaulted12Months = MockCreditAccount.makeCreditAccount(hasEverDefaulted: true, monthsSinceLastDefaulted: 12)
        XCTAssertEqual(CreditReportViewModel.getDefaultedText(from: creditAccountDefaulted12Months), "You last defaulted 12 months ago")
        let creditAccountNoDefaults = MockCreditAccount.makeCreditAccount(hasEverDefaulted: false, monthsSinceLastDefaulted: -1)
        XCTAssertEqual(CreditReportViewModel.getDefaultedText(from: creditAccountNoDefaults), "You have no defaults on file")
    }
    
    func test_getMissedPaymentsText_returnsCorrectValue() {
        let creditAccountDelinquentOneMonth = MockCreditAccount.makeCreditAccount(monthsSinceLastDelinquent: 1, hasEverBeenDelinquent: true)
        XCTAssertEqual(CreditReportViewModel.getMissedPaymentsText(from: creditAccountDelinquentOneMonth), "You last missed a payment 1 month ago")
        let creditAccountDelinquent12Months = MockCreditAccount.makeCreditAccount(monthsSinceLastDelinquent: 12, hasEverBeenDelinquent: true)
        XCTAssertEqual(CreditReportViewModel.getMissedPaymentsText(from: creditAccountDelinquent12Months), "You last missed a payment 12 months ago")
        let creditAccountNoDelinquents = MockCreditAccount.makeCreditAccount(hasEverDefaulted: false, monthsSinceLastDefaulted: -1)
        XCTAssertEqual(CreditReportViewModel.getMissedPaymentsText(from: creditAccountNoDelinquents), "You have no missed payments on file")
    }
}
