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
        let viewModel = DashboardViewModel(creditFetcher: CreditFetcher(endpoint: Endpoints.creditValues.getEndpoint()))
        let initialVC = DashboardViewController(viewModel: viewModel)
        bind(viewModel: viewModel)
        navigationController.pushViewController(initialVC, animated: false)
    }
    
    func goToCreditReport(with account: CreditAccount) {
        let viewModel = CreditReportViewModel(creditAccount: account)
        let vc = CreditReportDetailsViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func bind(viewModel: DashboardViewModel) {
        viewModel.sceneEnded.sink { [weak self] route in
            switch route {
            case .creditDetails(let account):
                self?.goToCreditReport(with: account)
            }
        }.store(in: &cancellables)
    }
}
