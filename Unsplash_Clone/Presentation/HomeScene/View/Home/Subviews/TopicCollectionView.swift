//
//  TopicCollectionView.swift
//  Unsplash_Clone
//
//  Created by 이원빈 on 2023/04/17.
//

import UIKit

final class TopicCollectionView: UICollectionView {
    
    init() {
        super.init(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        setupInitialSetting()
        setBackGround()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupInitialSetting() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        showsHorizontalScrollIndicator = false
        register(TopicCell.self,
                 forCellWithReuseIdentifier: TopicCell.identifier)
    }
    
    private func setBackGround() {
        let bgView = UIView()
        bgView.frame = CGRect(origin: frame.origin, size: CGSize(width: 428, height: 44))
        bgView.backgroundColor = .clear
        backgroundView = bgView
    }
    
    func makeLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = .init(width: 150, height: 44)
        setCollectionViewLayout(layout, animated: false)
    }
    
    private func setGradient(color: UIColor) {
        let gradient = CAGradientLayer()
        gradient.frame = .init(origin: .zero, size: CGSize(width: 428, height: 64))
        gradient.colors = [
            color.withAlphaComponent(0.4).cgColor,
            color.withAlphaComponent(0.0).cgColor
        ]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        backgroundView?.layer.addSublayer(gradient)
    }
    
    override func draw(_ rect: CGRect) {
        let separator = UIBezierPath()
        separator.move(to: CGPoint(x: 0, y: bounds.maxY-5))
        separator.addLine(to: CGPoint(x: UIScreen.main.bounds.maxX, y: bounds.maxY-5))
        separator.lineWidth = 1
        UIColor.white.setStroke()
        separator.stroke()
        separator.close()
    }
}
