//
//  ViewController.swift
//  ClearScoreTechTest
//
//  Created by Sophie Clark on 18/03/2022.
//

import UIKit
import Combine

class DashboardViewController: NiblessViewController {
    private let viewModel: DashboardViewModel
    private var scoreView: ScoreView!
    private let loadingSpinner: UIActivityIndicatorView
    private var cancellables: [AnyCancellable] = []
    
    init(viewModel: DashboardViewModel) {
        self.viewModel = viewModel
        self.loadingSpinner = UIActivityIndicatorView(style: .large)
        self.loadingSpinner.hidesWhenStopped = true
        super.init()
        bind()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func bind() {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        
        viewModel.$creditResult
            .sink(receiveValue: { [weak self] result in
                self?.render(with: result)
            })
            .store(in: &cancellables)
    }
    
    private func render(with state: DashboardViewModel.CreditResult) {
        switch state {
        case .success(let scoreViewModel):
            loadingSpinner.stopAnimating()
        case .error(let error):
            loadingSpinner.stopAnimating()
        case .loading:
            loadingSpinner.startAnimating()
            return
        }
    }
    
    
}

