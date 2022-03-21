//
//  MockNavigationController.swift
//  ClearScoreTechTestTests
//
//  Created by Sophie Clark on 21/03/2022.
//

import UIKit

class MockNavigationController: UINavigationController {
    var pushViewControllerCalled = false
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushViewControllerCalled = true
    }
}
