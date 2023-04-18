//
//  ImageCell.swift
//  Unsplash_Clone
//
//  Created by 이원빈 on 2023/04/16.
//

import UIKit
import SnapKit

final class ImageCell: UITableViewCell {
    static let identifier = "ImageCell"
    
    private let unsplashImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "photo1")
        imageView.backgroundColor = .systemBackground
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let unsplashTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "테스트 레이블"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()
    
    // MARK: Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    func setupData(image: UIImage, title: String) {
        unsplashImage.image = image.resizeTo(newWidth: UIScreen.main.bounds.width)
        unsplashTitle.text = title
    }
    
    func fetchCellHeight() -> CGFloat {
        return unsplashImage.image!.size.height
    }
}

// MARK: - Layout Constraints
private extension ImageCell {
    func addSubviews() {
        contentView.addSubview(unsplashImage)
        contentView.addSubview(unsplashTitle)
    }
    
    func setupLayout() {
        unsplashImage.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.size.width.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        unsplashTitle.snp.makeConstraints {
            $0.leading.equalTo(unsplashImage.snp.leading).offset(8)
            $0.bottom.equalTo(unsplashImage.snp.bottom).offset(-8)
        }
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct ImageCell_Preview: PreviewProvider {
    static var previews: some View {
        ImageCell(style: .default, reuseIdentifier: ImageCell.identifier)
            .showPreview()
    }
}
#endif
