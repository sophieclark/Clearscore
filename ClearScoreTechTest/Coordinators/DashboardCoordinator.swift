//
//  DashboardCoordinator.swift
//  ClearScoreTechTest
//
//  Created by Sophie Clark on 19/03/2022.
//

import Foundation
import UIKit
import Combine

enum DashboardRoute {
    case creditDetails(CreditAccount)
}

class DashboardCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    private var cancellables = Set<AnyCancellable>()
    
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
        bind(viewModel: viewModel)
        navigationController.pushViewController(initialVC, animated: false)
    }
    
    func bind(viewModel: DashboardViewModel) {
        viewModel.sceneEnded.sink { route in
            switch route {
            case .creditDetails(let account):
                break
            }
        }.store(in: &cancellables)
    }
}
