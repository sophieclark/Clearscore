//
//  CreditReportDetailsViewController.swift
//  ClearScoreTechTest
//
//  Created by Sophie Clark on 20/03/2022.
//

import UIKit

class CreditReportDetailsViewController: NiblessViewController {
    private let viewModel: CreditReportViewModel
    var scoreLabel: UILabel!
    var outOfLabel: UILabel!
    var changesView: UIView!
    var changesContainer: UIStackView!
    var insightsView: UIView!
    var insightsContainer: UIStackView!
    var scrollView: UIScrollView!
    
    
    init(viewModel: CreditReportViewModel) {
        self.viewModel = viewModel
        super.init()
        setupUI()
        setupConstraints()
        setupChangesContainer()
        setupInsightsContainer()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Credit report"
        
        scrollView = UIScrollView()
        view.addSubview(scrollView)
        
        scoreLabel = UILabel()
        scoreLabel.text = "\(viewModel.creditScore)"
        scoreLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        scrollView.addSubview(scoreLabel)
        
        outOfLabel = UILabel()
        outOfLabel.text = viewModel.outOfText
        scrollView.addSubview(outOfLabel)
        
        changesView = UIView()
        changesView.backgroundColor = .systemGroupedBackground
        changesView.layer.cornerRadius = 6
        scrollView.addSubview(changesView)
        
        changesContainer = UIStackView()
        changesContainer.alignment = .fill
        changesContainer.axis = .vertical
        changesContainer.spacing = 4
        changesView.addSubview(changesContainer)
        
        insightsView = UIView()
        insightsView.layer.borderWidth = 1
        insightsView.layer.borderColor = UIColor.opaqueSeparator.cgColor
        insightsView.layer.cornerRadius = 6
        scrollView.addSubview(insightsView)
        
        insightsContainer = UIStackView()
        insightsContainer.alignment = .fill
        insightsContainer.axis = .vertical
        insightsContainer.spacing = 4
        insightsView.addSubview(insightsContainer)
    }
    
    private func setupConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.topAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        scoreLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        outOfLabel.translatesAutoresizingMaskIntoConstraints = false
        outOfLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 4).isActive = true
        outOfLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        changesView.translatesAutoresizingMaskIntoConstraints = false
        changesView.topAnchor.constraint(equalTo: outOfLabel.bottomAnchor, constant: 8).isActive = true
        changesView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 8).isActive = true
        changesView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -8).isActive = true
        changesView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -16).isActive = true
        
        changesContainer.translatesAutoresizingMaskIntoConstraints = false
        changesContainer.topAnchor.constraint(equalTo: changesView.topAnchor, constant: 8).isActive = true
        changesContainer.leadingAnchor.constraint(equalTo: changesView.leadingAnchor, constant: 8).isActive = true
        changesContainer.trailingAnchor.constraint(equalTo: changesView.trailingAnchor, constant: -8).isActive = true
        changesContainer.widthAnchor.constraint(equalTo: changesView.widthAnchor, constant: -16).isActive = true
        changesContainer.bottomAnchor.constraint(equalTo: changesView.bottomAnchor, constant: -8).isActive = true
        
        insightsView.translatesAutoresizingMaskIntoConstraints = false
        insightsView.topAnchor.constraint(equalTo: changesView.bottomAnchor, constant: 8).isActive = true
        insightsView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 8).isActive = true
        insightsView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -8).isActive = true
        insightsView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -16).isActive = true
        
        insightsContainer.translatesAutoresizingMaskIntoConstraints = false
        insightsContainer.topAnchor.constraint(equalTo: insightsView.topAnchor, constant: 8).isActive = true
        insightsContainer.leadingAnchor.constraint(equalTo: insightsView.leadingAnchor, constant: 8).isActive = true
        insightsContainer.trailingAnchor.constraint(equalTo: insightsView.trailingAnchor, constant: -8).isActive = true
        insightsContainer.bottomAnchor.constraint(equalTo: insightsView.bottomAnchor, constant: -8).isActive = true
    }
    
    private func setupChangesContainer() {
        changesContainer.addArrangedSubview(makeSeparatorLine())
        let titleLabel = UILabel()
        titleLabel.text = viewModel.changesTitle
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        changesContainer.addArrangedSubview(titleLabel)
        
        if viewModel.hasShortTermDebt || viewModel.shortTermDebtChange != 0 {
            let shortTermTitleLabel = UILabel()
            shortTermTitleLabel.numberOfLines = 0
            shortTermTitleLabel.text = "\(viewModel.shortTermDebtTitle) £\(viewModel.shortTermDebtValue)"
            
            changesContainer.addArrangedSubview(shortTermTitleLabel)
    
            let shortTermChangedByLabel = UILabel()
            shortTermChangedByLabel.numberOfLines = 0
            if viewModel.shortTermDebtChange != 0 {
                shortTermChangedByLabel.text = "\(viewModel.shortTermDebtChangeTitle) £\(viewModel.shortTermDebtChange)"
            } else {
                shortTermChangedByLabel.text = viewModel.shortTermDebtChangeTitle
            }
            changesContainer.addArrangedSubview(shortTermChangedByLabel)
        }
        if viewModel.hasLongTermDebt || viewModel.longTermDebtChange != 0 {
            let longTermTitleLabel = UILabel()
            longTermTitleLabel.numberOfLines = 0
            longTermTitleLabel.text = "\(viewModel.longTermDebtTitle) £\(viewModel.longTermDebtValue)"
            
            changesContainer.addArrangedSubview(longTermTitleLabel)
            
            let longTermChangedByLabel = UILabel()
            longTermChangedByLabel.numberOfLines = 0
            if viewModel.longTermDebtChange != 0 {
                longTermChangedByLabel.text = "\(viewModel.longTermDebtChangeTitle) £\(viewModel.longTermDebtChange)"
            } else {
                longTermChangedByLabel.text = "\(viewModel.longTermDebtChangeTitle)"
            }
            changesContainer.addArrangedSubview(longTermChangedByLabel)
        }
        changesContainer.addArrangedSubview(makeSeparatorLine())
    }
    
    private func setupInsightsContainer() {
        let titleLabel = UILabel()
        titleLabel.text = viewModel.insightsTitle
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        insightsContainer.addArrangedSubview(titleLabel)
        
        let delinquentLabel = UILabel()
        delinquentLabel.text = viewModel.missedPayemntsText
        insightsContainer.addArrangedSubview(delinquentLabel)
        
        let defaultsLabel = UILabel()
        defaultsLabel.text = viewModel.defaultedText
        insightsContainer.addArrangedSubview(defaultsLabel)
        
    }
    
    private func makeSeparatorLine() -> UIView {
        let separatorLine = UIView()
        separatorLine.layer.borderColor = UIColor.opaqueSeparator.cgColor
        separatorLine.layer.borderWidth = 2
        return separatorLine
    }
}
