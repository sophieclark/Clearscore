//
//  DashboardCoordinator.swift
//  ClearScoreTechTest
//
//  Created by Sophie Clark on 19/03/2022.
//

import Foundation
import UIKit

class DashboardCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        #if TEST
        let viewModel = DashboardViewModel(creditFetcher: CreditFetcher(endpoint: Endpoints.creditValues.getTestData()))
        let initialVC = DashboardViewController(viewModel: viewModel)
        navigationController.pushViewController(initialVC, animated: false)
        #else
        let viewModel = DashboardViewModel(creditFetcher: CreditFetcher(endpoint: Endpoints.creditValues.getEndpoint()))
        let initialVC = DashboardViewController(viewModel: viewModel)
        navigationController.pushViewController(initialVC, animated: false)
        #endif
    }
    
    
}
