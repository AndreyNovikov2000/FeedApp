//
//  SparkingScrollView.swift
//  FeedApp
//
//  Created by Andrey Novikov on 1/14/21.
//

import UIKit

class SparkingScrollView: UIScrollView {
    
    
    // MARK: - Public properties
    
    var numberOfCells = 3 {
        didSet {
            layoutIfNeeded()
            setupScrollView()
        }
    }
    
    private var sparkingViews: [SparkingView] = []
    private let cellHeight: CGFloat = 350
    
    // MARK: - Object livecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupScrollView()
        setupSparkViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // MARK: - Private methods
    
    // MARK: - Setup
    
    private func setupScrollView() {
        contentSize = CGSize(width: bounds.width, height: CGFloat(numberOfCells) * cellHeight)
        backgroundColor = .white
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
    }
    
    private func setupSparkViews() {
        (0..<numberOfCells).forEach { (index) in
            let sparkingView = SparkingView()
            sparkingView.frame = CGRect(x: 0,
                                        y: CGFloat(index) * (16 + 60 + 16 + 15 + bounds.width * 2/3),
                                        width: bounds.width,
                                        height: sparkingView.imageLayerOrigin.y)
           
            addSubview(sparkingView)
            self.sparkingViews.append(sparkingView)
        }
    }
}
