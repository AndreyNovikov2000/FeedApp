//
//  SparkingView.swift
//  FeedApp
//
//  Created by Andrey Novikov on 1/14/21.
//

import UIKit

class SparkingView: UIView {
    
    // MARK: - Instance properties
    
    var imageLayerOrigin: CGPoint {
        imageLayer.bounds.origin
    }
    
    lazy var avatarImageLayer = setupLayer()
    lazy var nameLabelLayer = setupLayer()
    lazy var dateLabelLayer = setupLayer()
    lazy var imageLayer = setupLayer()
    
    // MARK: - Nested types
    
    enum PathType {
        case circle, roundedRect(radius: CGFloat)
    }
    
    // MARK: - Private Properties
    
    // MARK: - K
    
    private let strokeColor = UIColor(white: 0.75, alpha: 1)
    private let fillColor = UIColor(white: 0.75, alpha: 1)
    
    
    // MARK: - Object livecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupLayout()
    }
    
    // MARK: - Private methods
    
    
    private func setupLayout() {
        let avatarFrame = CGRect(origin: CGPoint(x: 16, y: 16),
                                 size: CGSize(width: 60, height: 60))
        
        avatarImageLayer.frame = avatarFrame
        avatarImageLayer.path = drawPath(type: .circle, rect: avatarFrame).cgPath
        layer.addSublayer(avatarImageLayer)
        
        
        let nameLabelFrame = CGRect(origin: CGPoint(x: 46, y: 13),
                                    size: CGSize(width:  bounds.width - (60 + 16 + 10 + 16), height: 16))
        nameLabelLayer.frame = nameLabelFrame
        nameLabelLayer.path = drawPath(type: .roundedRect(radius: 40), rect: nameLabelFrame).cgPath
        layer.addSublayer(nameLabelLayer)
        
        let dateLabelFrame = CGRect(origin: CGPoint(x: nameLabelFrame.origin.x, y: nameLabelFrame.origin.y + 12),
                                    size: CGSize(width: nameLabelFrame.width * 2/3 + 20, height: nameLabelFrame.size.height - 1))
        dateLabelLayer.frame = dateLabelFrame
        dateLabelLayer.path = drawPath(type: .roundedRect(radius: 40), rect: dateLabelFrame).cgPath
        layer.addSublayer(dateLabelLayer)
        
        let imageFrame = CGRect(origin: CGPoint(x: 8, y: dateLabelFrame.origin.y + 20),
                                size: CGSize(width: bounds.width - 32, height: bounds.width * 2/3))
        imageLayer.frame = imageFrame
        imageLayer.path = drawPath(type: .roundedRect(radius: 20), rect: imageFrame).cgPath
        layer.addSublayer(imageLayer)
        
        
        // yOrigin: 16 + 60 + 16 + 15 + bounds.width * 2/3
        
    }
    
    
    private func drawPath(type: PathType, rect: CGRect) -> UIBezierPath {
        let path: UIBezierPath
        
        switch type {
        case .circle:
            path = UIBezierPath(arcCenter: CGPoint(x: rect.size.width / 2, y: rect.size.height / 2),
                                radius: rect.size.width / 2,
                                startAngle: 0,
                                endAngle: 2 * CGFloat.pi,
                                clockwise: true)
        case .roundedRect(let radius):
            path = UIBezierPath(roundedRect: rect, cornerRadius: radius)
        }
        
        return path
    }
    
    // MARK: - Setup
    
    private func setupLayer() -> CAShapeLayer {
        let layer = CAShapeLayer()
        layer.strokeColor = strokeColor.cgColor
        layer.fillColor = fillColor.cgColor
        
        let alphaAnimation = CABasicAnimation(keyPath: "opacity")
        alphaAnimation.fromValue = 0.2
        alphaAnimation.toValue = 0.8
        alphaAnimation.autoreverses = true
        alphaAnimation.duration = 1
        alphaAnimation.repeatCount = Float.infinity
        layer.add(alphaAnimation, forKey: "fillColor")
        
        return layer
    }
}

