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
        topLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        topLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 8).isActive = true
        scoreLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        scoreLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        bottomLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 8).isActive = true
        bottomLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 8).isActive = true
        bottomLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    private func drawCircle() {
        let path = UIBezierPath(arcCenter: CGPoint(x: self.frame.midX, y: self.frame.midY), radius: self.frame.midY - 8, startAngle: -(CGFloat.pi / 2), endAngle: CGFloat.pi + (CGFloat.pi / 2), clockwise: true)
        let circleLayer = CAShapeLayer()
        circleLayer.path = path.cgPath
        circleLayer.lineWidth = 2
        circleLayer.strokeColor = UIColor.black.cgColor
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
