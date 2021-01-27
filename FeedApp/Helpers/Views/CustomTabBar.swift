//
//  CustomTabBar.swift
//  FeedApp
//
//  Created by Andrey Novikov on 1/16/21.
//

import UIKit

class CustomTabBar: UITabBar {
        
    // MARK: - UI
    
    lazy var pointView: UIView = {
        let view = UIView(frame: CGRect(x: 30, y: 37, width: 8, height: 8))
        view.layer.cornerRadius = view.frame.width / 2
        view.backgroundColor = .systemBlue
        return view
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        let bottonSide = (radius * 2) - 16
        button.frame = CGRect(x: frame.width / 2 - bottonSide / 2,
                              y: -bottonSide / 2,
                              width: bottonSide,
                              height: bottonSide)
        button.backgroundColor = .white
        button.layer.cornerRadius = button.frame.width / 2
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        button.setAttributedTitle(NSAttributedString(string: "+",
                                                     attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 40)]),
                                  for: .normal)
        return button
    }()
    

    
    // MARK: - Private properties
    
    private var centerWidth: CGFloat {
        return bounds.width / 2
    }
    
    private let radius: CGFloat = 36
    private let tabBarColor = UIColor.white
    
    private let shapeLayer = CAShapeLayer()
    
    // MARK: - Object livecycle
    
    override func draw(_ rect: CGRect) {
        setupTabBar()
        setupShapelayer()
        addViews()
    }
    
    // MARK: - Private methods
    
    private func addViews() {
        addSubview(addButton)
        addSubview(pointView)
    }
    
    // MARK: - Setup
    
    private func setupTabBar() {
        shadowImage = UIImage()
        backgroundImage = UIImage()
        barTintColor = .clear
    }
    
    private func setupShapelayer() {
        shapeLayer.path = drawPath().cgPath
        shapeLayer.strokeColor = tabBarColor.cgColor
        shapeLayer.fillColor = tabBarColor.cgColor
        self.layer.insertSublayer(shapeLayer, at: 0)
    }
    
    private func drawPath() -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 30))
        path.addQuadCurve(to: CGPoint(x: 30, y: 0), controlPoint: CGPoint(x: 3, y: 3))
        path.addLine(to: CGPoint(x: (centerWidth / 2) - radius, y: 0))
        path.addArc(withCenter: CGPoint(x: centerWidth, y: 0),
                    radius: radius,
                    startAngle: CGFloat.pi,
                    endAngle: 0,
                    clockwise: false)
        path.addLine(to: CGPoint(x: bounds.width - 30, y: 0))
        path.addQuadCurve(to: CGPoint(x: bounds.width, y: 30), controlPoint: CGPoint(x: bounds.width - 3, y: 3))
        path.addLine(to: CGPoint(x: bounds.width, y: bounds.height))
        path.addLine(to: CGPoint(x: 0, y: bounds.height))
        path.close()
        return path
    }
}
