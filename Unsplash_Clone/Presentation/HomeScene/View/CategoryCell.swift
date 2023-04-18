//
//  CategoryCell.swift
//  Unsplash_Clone
//
//  Created by 이원빈 on 2023/04/16.
//

import UIKit

final class CategoryCell: UICollectionViewCell {
    static let identifier = "CategoryCell"
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    private let underBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupData(text: String) {
        label.text = text
        underBar.isHidden = true
    }
    
    func setUnderBar() {
        underBar.isHidden = false
    }
    
    func hideUnderBar() {
        underBar.isHidden = true
    }
}

// MARK: - Layout Constraints
private extension CategoryCell {
    func addSubviews() {
        addSubview(label)
        addSubview(underBar)
    }
    
    func setupLayout() {
        label.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        underBar.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().offset(7)
            $0.height.equalTo(3)
        }
    }
}
