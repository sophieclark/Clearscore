//
//  ViewController.swift
//  ClearScoreTechTest
//
//  Created by Sophie Clark on 18/03/2022.
//

import UIKit

class DashboardViewController: NiblessViewController {
    let viewModel: DashboardViewModel
    var scoreLabel: UILabel!
    
    init(viewModel: DashboardViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.backgroundColor = .white
        scoreLabel = 
    }
}

