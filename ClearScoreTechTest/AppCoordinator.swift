//
//  AppCoordinator.swift
//  ClearScoreTechTest
//
//  Created by Sophie Clark on 19/03/2022.
//

import Foundation
import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}

class AppCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let dashboardCoordinator = DashboardCoordinator(navigationController: navigationController)
        childCoordinators.append(dashboardCoordinator)
        dashboardCoordinator.start()
    }
}

class DashboardCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = DashboardViewModel(creditFetcher: CreditFetcher(endpoint: Endpoints.creditValues.getEndpoint()))
        let initialVC = DashboardViewController(viewModel: viewModel)
        navigationController.pushViewController(initialVC, animated: false)
    }
    
    
}
