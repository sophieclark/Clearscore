//
//  ErrorView.swift
//  ClearScoreTechTest
//
//  Created by Sophie Clark on 20/03/2022.
//

import UIKit

class ErrorView: NiblessView {
    var titleLabel: UILabel!
    var descriptionLabel: UILabel!
    var retryButton: UIButton!
    
    let viewModel: ErrorViewModel
    
    init(viewModel: ErrorViewModel) {
        self.viewModel = viewModel
        super.init()
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        titleLabel = UILabel()
        titleLabel.font = .preferredFont(forTextStyle: .title1)
        titleLabel.text = viewModel.errorTitle
        titleLabel.textAlignment = .center
        addSubview(titleLabel)
        
        descriptionLabel = UILabel()
        descriptionLabel.text = viewModel.errorDescription
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        addSubview(descriptionLabel)
        
        retryButton = UIButton(configuration: .filled(), primaryAction: nil)
        retryButton.setTitle("errorview.button.text".localized(), for: .normal)
        retryButton.addTarget(self, action: #selector(retryTapped), for: .touchUpInside)
        addSubview(retryButton)
    }
    
    @objc
    private func retryTapped() {
        viewModel.retryTapped.send(true)
    }
    
    private func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -8).isActive = true
        
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24).isActive = true
        
        retryButton.translatesAutoresizingMaskIntoConstraints = false
        retryButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16).isActive = true
        retryButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
}
