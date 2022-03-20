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
    var changesContainer: UIStackView!
    var insightsContainer: UIStackView!
    var scrollView: UIScrollView!
    
    
    init(viewModel: CreditReportViewModel) {
        self.viewModel = viewModel
        super.init()
        setupUI()
    }
    
    private func setupUI() {
        scoreLabel = UILabel()
        scoreLabel.text = "\(viewModel.creditScore)"
        view.addSubview(scoreLabel)
        
    }
    
    private func setupConstraints() {
        
    }
    
    private func setupChangesContainer() {
        
    }
    
    private func setupInsightsContainer() {
        
    }
}
