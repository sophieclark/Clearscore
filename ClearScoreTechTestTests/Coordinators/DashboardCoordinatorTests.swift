//
//  DashboardCoordinatorTests.swift
//  ClearScoreTechTestTests
//
//  Created by Sophie Clark on 21/03/2022.
//

import XCTest
@testable import ClearScoreTechTest

class DashboardCoordinatorTests: XCTestCase {
    
    func test_startTriggersPush() {
        let mockNavigationController = MockNavigationController()
        let sut = DashboardCoordinator(navigationController: mockNavigationController)
        sut.start()
        XCTAssert(mockNavigationController.pushViewControllerCalled)
        XCTAssert(sut.childCoordinators.isEmpty)
    }
    
    func test_goToCreditReport_triggersPush() {
        let mockNavigationController = MockNavigationController()
        let sut = DashboardCoordinator(navigationController: mockNavigationController)
        sut.goToCreditReport(with: MockCreditAccount.makeCreditAccount())
        XCTAssert(mockNavigationController.pushViewControllerCalled)
        XCTAssert(sut.childCoordinators.isEmpty)
    }
    
    func test_bindTriggersPush_onSendingCreditDetailsRoute() {
        let mockNavigationController = MockNavigationController()
        let sut = DashboardCoordinator(navigationController: mockNavigationController)
        let viewModel = DashboardViewModel(creditFetcher: CreditFetcher(endpoint: Endpoints.creditValues.getTestData(success: true, jsonToLoad: "mockcredit-values")))
        sut.bind(viewModel: viewModel)
        viewModel.sceneEnded.send(DashboardRoute.creditDetails(MockCreditAccount.makeCreditAccount()))
        XCTAssert(mockNavigationController.pushViewControllerCalled)
    }
}
