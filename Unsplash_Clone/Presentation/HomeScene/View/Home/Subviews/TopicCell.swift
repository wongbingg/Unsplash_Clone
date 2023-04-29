//
//  TopicCell.swift
//  Unsplash_Clone
//
//  Created by 이원빈 on 2023/04/16.
//

import UIKit

final class TopicCell: UICollectionViewCell {
    static let identifier = "TopicCell"
    
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

// MARK: - Layout Settings
private extension TopicCell {
    func addSubviews() {
        addSubview(label)
        addSubview(underBar)
    }
    
    func setupLayout() {
        label.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.leadingMargin.equalTo(8)
            $0.trailingMargin.equalTo(-8)
        }
        underBar.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().offset(7)
            $0.height.equalTo(3)
        }
    }
}
