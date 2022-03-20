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
        var viewModel: DashboardViewModel
        if CommandLine.arguments.contains("-launchWithSuccess") || CommandLine.arguments.contains("-launchWithFailure") {
            viewModel = DashboardViewModel(creditFetcher: CreditFetcher(endpoint: Endpoints.creditValues.getTestData(success: CommandLine.arguments.contains("-launchWithSuccess"))))
        } else {
            viewModel = DashboardViewModel(creditFetcher: CreditFetcher(endpoint: Endpoints.creditValues.getEndpoint()))
        }
        let initialVC = DashboardViewController(viewModel: viewModel)
        navigationController.pushViewController(initialVC, animated: false)
    }
    
    
}
