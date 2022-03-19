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
    private var scoreViewContainer: UIView
    private let loadingSpinner: UIActivityIndicatorView
    private var cancellables: [AnyCancellable] = []
    
    init(viewModel: DashboardViewModel) {
        self.viewModel = viewModel
        self.scoreViewContainer = UIView()
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
        view.addSubview(scoreViewContainer)
        view.addSubview(loadingSpinner)
        
        scoreViewContainer.translatesAutoresizingMaskIntoConstraints = false
        scoreViewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scoreViewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scoreViewContainer.heightAnchor.constraint(equalTo: scoreViewContainer.widthAnchor).isActive = true
        scoreViewContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        loadingSpinner.translatesAutoresizingMaskIntoConstraints = false
        loadingSpinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loadingSpinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true 
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
        case .loading:
            loadingSpinner.startAnimating()
            return
        }
    }
    
    private func setupScoreView(with viewModel: ScoreViewModel) {
        let scoreView = ScoreView(viewModel: viewModel)
        scoreViewContainer.addSubview(scoreView)
        scoreView.translatesAutoresizingMaskIntoConstraints = false
        scoreView.topAnchor.constraint(equalTo: scoreViewContainer.topAnchor).isActive = true
        scoreView.leadingAnchor.constraint(equalTo: scoreViewContainer.leadingAnchor).isActive = true
        scoreView.trailingAnchor.constraint(equalTo: scoreViewContainer.trailingAnchor).isActive = true
        scoreView.bottomAnchor.constraint(equalTo: scoreViewContainer.bottomAnchor).isActive = true
    }
}

