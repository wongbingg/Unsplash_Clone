//
//  CategoryCollectionView.swift
//  Unsplash_Clone
//
//  Created by 이원빈 on 2023/04/17.
//

import UIKit

final class CategoryCollectionView: UICollectionView {
    
    init(layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: layout)
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
        register(CategoryCell.self,
                 forCellWithReuseIdentifier: CategoryCell.identifier)
    }
    
    private func setBackGround() {
        let bgView = UIView()
        bgView.frame = CGRect(origin: frame.origin, size: CGSize(width: 428, height: 44))
        backgroundView = bgView
        setGradient(color: .black)
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
