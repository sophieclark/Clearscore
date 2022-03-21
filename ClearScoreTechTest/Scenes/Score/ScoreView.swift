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
    
    private var circleLayer: CAShapeLayer?
    private var progressLayer: CAShapeLayer?
    
    init(viewModel: ScoreViewModel) {
        self.viewModel = viewModel
        super.init()
        setupUI()
        setupConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        drawCircle()
        drawProgressArc()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        circleLayer?.removeAllAnimations()
        circleLayer?.removeFromSuperlayer()
        progressLayer?.removeAllAnimations()
        progressLayer?.removeFromSuperlayer()
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
    
    private func getArc(from startAngle: CGFloat, to  endAngle: CGFloat, radius: CGFloat) -> UIBezierPath {
        return UIBezierPath(arcCenter: CGPoint(x: self.frame.midX, y: self.frame.midY), radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
    }
    
    private func getShape(with path: CGPath, lineWidth: CGFloat, lineCap: CAShapeLayerLineCap = .butt, strokeColor: CGColor = UIColor.lineColor.cgColor) -> CAShapeLayer {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineCap = lineCap
        shapeLayer.strokeColor = strokeColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        return shapeLayer
    }
    
    private func drawCircle() {
        let radius = 125 > self.frame.midY - 16 ? self.frame.midY - 16 : 125
        let path = getArc(from: -(CGFloat.pi / 2), to: CGFloat.pi + (CGFloat.pi / 2), radius: radius)
        circleLayer = getShape(with: path.cgPath, lineWidth: 2)
        layer.addSublayer(circleLayer!)
    }
    
    private func drawProgressArc() {
        let radius = 120 > self.frame.midY - 20 ? self.frame.midY - 20 : 120
        let path = getArc(from: -(CGFloat.pi / 2),
                           to: -(CGFloat.pi / 2) + ((CGFloat(viewModel.score) / CGFloat(viewModel.max)) * (CGFloat.pi  * 2)),
                           radius: radius)
        progressLayer = getShape(with: path.cgPath, lineWidth: 4, lineCap: .round)
        addAnimation(to: progressLayer!, add: 0.75, key: "drawProgressAnimation")
        layer.addSublayer(progressLayer!)
    }
    
    private func addAnimation(to layer: CALayer, add duration: CFTimeInterval = 0, key: String) {
        let drawAnimation = CABasicAnimation(keyPath: "strokeEnd")
        drawAnimation.duration = 0.75
        drawAnimation.repeatCount = 1.0
        drawAnimation.isRemovedOnCompletion = false
        drawAnimation.fromValue = 0
        drawAnimation.toValue = 1
        drawAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        drawAnimation.beginTime = CACurrentMediaTime() + duration
        drawAnimation.fillMode = .backwards
        layer.add(drawAnimation, forKey: key)
    }
}
