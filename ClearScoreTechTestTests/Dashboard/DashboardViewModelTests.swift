//
//  DashboardViewModelTests.swift
//  ClearScoreTechTestTests
//
//  Created by Sophie Clark on 20/03/2022.
//

import XCTest
import Combine
@testable import ClearScoreTechTest

class DashboardViewModelTests: XCTestCase {
    
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        self.cancellables = []
        super.setUp()
    }
    
    func test_refresh_updatesStateWithCreditAccount_onSuccess() {
        let creditFetcher = CreditFetcher(endpoint: Endpoints.creditValues.getTestData(success: true, jsonToLoad: "mockcredit-values"))
        let sut = DashboardViewModel(creditFetcher: creditFetcher)
        
        let expectedScoreViewModel = ScoreViewModel(score: 514, max: 700)
        
        var expectedValues: [DashboardViewModel.CreditResult] = [.loading, .loading, .success(expectedScoreViewModel)]
        
        let creditResultExpectation = expectation(description: "recieve expected values in credit result \(#line) \(#file)")
        
        sut.$creditResult.sink { creditResult in
            guard let expectedValue = expectedValues.first else {
                XCTFail("received less values than expected")
                return
            }
            
            guard expectedValue == creditResult else {
                XCTFail("expectedValue \(expectedValue) did not match value from dataSource \(creditResult)")
                return
            }
            
            if case .success(let scoreViewModel) = creditResult {
                XCTAssertEqual(scoreViewModel, expectedScoreViewModel)
            }
            expectedValues = Array(expectedValues.dropFirst())
            
            if expectedValues.isEmpty {
                creditResultExpectation.fulfill()
            }
        }
        .store(in: &cancellables)
        
        sut.refresh()
        
        wait(for: [creditResultExpectation], timeout: 100)
    }
    
    
    func test_refresh_updatesStateWithError_onFailure() {
        let creditFetcher = CreditFetcher(endpoint: Endpoints.creditValues.getTestData(success: false, jsonToLoad: "mockcredit-values-fail"))
        let sut = DashboardViewModel(creditFetcher: creditFetcher)
        
        let expectedError = NetworkingError.parsing(description: "")
        
        var expectedValues: [DashboardViewModel.CreditResult] = [.loading, .loading, .error(expectedError)]
        
        let creditResultExpectation = expectation(description: "recieve expected values in credit result \(#line) \(#file)")
        
        sut.$creditResult.sink { creditResult in
            guard let expectedValue = expectedValues.first else {
                XCTFail("received less values than expected")
                return
            }
            
            guard expectedValue == creditResult else {
                XCTFail("expectedValue \(expectedValue) did not match value from dataSource \(creditResult)")
                return
            }
            expectedValues = Array(expectedValues.dropFirst())
            
            if case .error(let error) = creditResult {
                switch error {
                case .parsing(description: _):
                    break
                default:
                    XCTFail("Incorrect error type \(#file) \(#line)")
                }
            }
            
            if expectedValues.isEmpty {
                creditResultExpectation.fulfill()
            }
        }
        .store(in: &cancellables)
        
        sut.refresh()
        
        wait(for: [creditResultExpectation], timeout: 100)
    }
}
