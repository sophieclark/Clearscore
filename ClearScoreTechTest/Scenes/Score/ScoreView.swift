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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        drawCircle()
    }
    
    private func setupUI() {
        scoreLabel = UILabel()
        scoreLabel.font = scoreLabel.font.withSize(60)
        let scorePercent = Double(viewModel.score) / Double(viewModel.max)
        if scorePercent < 0.33 {
            scoreLabel.textColor = .systemRed
        } else if scorePercent >= 0.33 && scorePercent < 0.66 {
            scoreLabel.textColor = .systemYellow
        } else {
            scoreLabel.textColor = .systemGreen
        }
        scoreLabel.text = "\(viewModel.score)"
        scoreLabel.textAlignment = .center
        addSubview(scoreLabel)
        
        topLabel = UILabel()
        topLabel.text = viewModel.topLabelText
        topLabel.textAlignment = .center
        addSubview(topLabel)
        
        bottomLabel = UILabel()
        bottomLabel.text = viewModel.bottomLabelText
        bottomLabel.textAlignment = .center
        addSubview(bottomLabel)
    }
    
    private func setupConstraints() {
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.bottomAnchor.constraint(equalTo: scoreLabel.topAnchor).isActive = true
        topLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor).isActive = true
        scoreLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        scoreLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        bottomLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor).isActive = true
        bottomLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    private func drawCircle() {
        let radius = 125 > self.frame.midY - 16 ? self.frame.midY - 16 : 125
        let path = UIBezierPath(arcCenter: CGPoint(x: self.frame.midX, y: self.frame.midY), radius: radius, startAngle: -(CGFloat.pi / 2), endAngle: CGFloat.pi + (CGFloat.pi / 2), clockwise: true)
        let circleLayer = CAShapeLayer()
        circleLayer.path = path.cgPath
        circleLayer.lineWidth = 2
        circleLayer.strokeColor = UIColor.lineColor.cgColor
        circleLayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(circleLayer)
        addAnimation(to: circleLayer)
    }
    
    private func addAnimation(to layer: CALayer) {
        let drawAnimation = CABasicAnimation(keyPath: "strokeEnd")
        drawAnimation.duration = 0.75
        drawAnimation.repeatCount = 1.0
        drawAnimation.isRemovedOnCompletion = false
        drawAnimation.fromValue = 0
        drawAnimation.toValue = 1
        drawAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        layer.add(drawAnimation, forKey: "drawCircleAnimation")
    }
}
