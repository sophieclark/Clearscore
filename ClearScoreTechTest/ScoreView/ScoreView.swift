//
//  ScoreView.swift
//  ClearScoreTechTest
//
//  Created by Sophie Clark on 18/03/2022.
//

import UIKit

class ScoreView: NiblessView {
    var scoreLabel: UILabel!
    var topLabel: UILabel!
    var bottomLabel: UILabel!
    
    let viewModel: ScoreViewModel
    
    init(viewModel: ScoreViewModel) {
        self.viewModel = viewModel
        super.init()
        setupUI()
        setupConstraints()
    }
    
    func setupUI() {
        scoreLabel = UILabel()
        scoreLabel.text = "\(viewModel.score)"
        scoreLabel.textAlignment = .center
        
        topLabel = UILabel()
        topLabel.text = viewModel.topLabelText
        topLabel.textAlignment = .center
        
        bottomLabel = UILabel()
        bottomLabel.text = viewModel.bottomLabelText
        bottomLabel.textAlignment = .center
    }
    
    func setupConstraints() {
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        topLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 8).isActive = true
        scoreLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        scoreLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        bottomLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 8).isActive = true
        bottomLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
