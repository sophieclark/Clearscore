//
//  AppCoordinatorTests.swift
//  ClearScoreTechTestTests
//
//  Created by Sophie Clark on 21/03/2022.
//

import XCTest
@testable import ClearScoreTechTest

class AppCoordinatorTests: XCTestCase {

    func test_startTriggersNavigationPush_andChildAdded() {
        let mockNavigationController = MockNavigationController()
        let sut = AppCoordinator(navigationController: mockNavigationController)
        XCTAssertEqual(sut.childCoordinators.count, 0)
        sut.start()
        XCTAssert(mockNavigationController.pushViewControllerCalled)
        XCTAssertEqual(sut.childCoordinators.count, 1)
    }

}
