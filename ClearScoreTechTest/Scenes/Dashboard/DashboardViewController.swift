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
    private var loadedViewContainer: UIView
    private let loadingSpinner: UIActivityIndicatorView
    private var cancellables: [AnyCancellable] = []
    
    init(viewModel: DashboardViewModel) {
        self.viewModel = viewModel
        self.loadedViewContainer = UIView()
        self.loadingSpinner = UIActivityIndicatorView(style: .large)
        self.loadingSpinner.hidesWhenStopped = true
        super.init()
        setupView()
        bind()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.refresh()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(loadedViewContainer)
        view.addSubview(loadingSpinner)
        navigationItem.title = "Dashboard"
        
        loadedViewContainer.translatesAutoresizingMaskIntoConstraints = false
        loadedViewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        loadedViewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        loadedViewContainer.heightAnchor.constraint(equalTo: loadedViewContainer.widthAnchor).isActive = true
        loadedViewContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        loadingSpinner.translatesAutoresizingMaskIntoConstraints = false
        loadingSpinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loadingSpinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingSpinner.accessibilityIdentifier = "loading spinner"
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
            setupScoreView(with: scoreViewModel)
        case .error(let error):
            loadingSpinner.stopAnimating()
            setupErrorView(with: viewModel.errorViewModel(for: error))
        case .loading:
            loadedViewContainer.subviews.forEach { $0.removeFromSuperview() }
            loadingSpinner.startAnimating()
            return
        }
    }
    
    private func setupScoreView(with viewModel: ScoreViewModel) {
        loadedViewContainer.subviews.forEach {
            $0.removeFromSuperview()
        }
        let scoreView = ScoreView(viewModel: viewModel)
        loadedViewContainer.addSubview(scoreView)
        scoreView.translatesAutoresizingMaskIntoConstraints = false
        scoreView.topAnchor.constraint(equalTo: loadedViewContainer.topAnchor).isActive = true
        scoreView.leadingAnchor.constraint(equalTo: loadedViewContainer.leadingAnchor).isActive = true
        scoreView.trailingAnchor.constraint(equalTo: loadedViewContainer.trailingAnchor).isActive = true
        scoreView.bottomAnchor.constraint(equalTo: loadedViewContainer.bottomAnchor).isActive = true
    }
    
    private func setupErrorView(with errorViewModel: ErrorViewModel) {
        loadedViewContainer.subviews.forEach {
            $0.removeFromSuperview()
        }
        let errorView = ErrorView(viewModel: errorViewModel)
        loadedViewContainer.addSubview(errorView)
        errorView.translatesAutoresizingMaskIntoConstraints = false
        errorView.topAnchor.constraint(equalTo: loadedViewContainer.topAnchor).isActive = true
        errorView.leadingAnchor.constraint(equalTo: loadedViewContainer.leadingAnchor).isActive = true
        errorView.trailingAnchor.constraint(equalTo: loadedViewContainer.trailingAnchor).isActive = true
        errorView.bottomAnchor.constraint(equalTo: loadedViewContainer.bottomAnchor).isActive = true
        
        errorViewModel.retryTapped.sink { [weak self] value in
            if value {
                self?.viewModel.refresh()
            }
        }.store(in: &cancellables)
    }
}

