//
//  PhotoCell.swift
//  Unsplash_Clone
//
//  Created by 이원빈 on 2023/04/18.
//

import UIKit
import UnsplashPhotoPicker

final class PhotoCell: UITableViewCell {
    static let identifier = "PhotoCell"
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let dimmingView: UIView = {
        let view = UIView()
        // 그라데이션 처리
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 150)
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
//
        view.layer.addSublayer(gradientLayer)
        
        return view
    }()
    
    private let unsplashTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "테스트 레이블"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()
    
    private var imageDataTask: URLSessionDataTask?
    
    private static var cache: URLCache = {
        let memoryCapacity = 50 * 1024 * 1024
        let diskCapacity = 100 * 1024 * 1024
        let diskPath = "unsplash"
        
        return URLCache(
            memoryCapacity: memoryCapacity,
            diskCapacity: diskCapacity,
            diskPath: diskPath
        )
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
    
    func downloadPhoto(_ photo: UnsplashPhoto) {
        unsplashTitle.text = photo.user.name
        
        guard let url = photo.urls[.small] else { return }
        
        if let cachedResponse = PhotoCell.cache.cachedResponse(for: URLRequest(url: url)),
           let image = UIImage(data: cachedResponse.data) {
            photoImageView.image = image
            return
        }
        
        imageDataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            self.imageDataTask = nil
            
            guard let data = data,
                    let response = response,
                    let image = UIImage(data: data),
                    error == nil else { return }
            
            PhotoCell.cache.storeCachedResponse(
                .init(response: response, data: data),
                for: URLRequest(url: url)
            )
            
            DispatchQueue.main.async {
                UIView.transition(
                    with: self.photoImageView,
                    duration: 0.25,
                    options: [.transitionCrossDissolve]
                ) {
                    self.photoImageView.image = image
                }
            }
        }
        imageDataTask?.resume()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = UIImage()
//        photoImageView.layer.sublayers?.removeAll()
    }
}

// MARK: - Layout Settings
private extension PhotoCell {
    
    func addSubviews() {
        contentView.addSubview(photoImageView)
        photoImageView.addSubview(dimmingView)
        dimmingView.addSubview(unsplashTitle)
    }
    
    func setupLayout() {
        photoImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.size.width.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        dimmingView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(150)
        }
        
        unsplashTitle.snp.makeConstraints {
            $0.leading.equalTo(dimmingView.snp.leading).offset(8)
            $0.bottom.equalTo(dimmingView.snp.bottom).offset(-8)
        }
    }
}
