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
        let newURLString = url.absoluteString + "&w=\(UIScreen.main.bounds.width)"
        let newURL = URL(string: newURLString)!
        if let cachedResponse = PhotoCell.cache.cachedResponse(for: URLRequest(url: newURL)),
           let image = UIImage(data: cachedResponse.data) {
            photoImageView.image = image
//            photoImageView.image = image.resizeTo(newWidth: UIScreen.main.bounds.width)
//            self.setGradient(height: self.photoImageView.bounds.size.height)
            return
        }
        
        imageDataTask = URLSession.shared.dataTask(with: newURL) { [weak self] (data, response, error) in
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
//                    self.photoImageView.image = image.resizeTo(newWidth: UIScreen.main.bounds.width)
//                    self.setGradient(height: self.photoImageView.bounds.size.height)
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

// MARK: - Gradient Layer Settings (Fail..)
private extension PhotoCell {
    
    func setGradient(height: CGFloat) {
        let gradientLayer = self.createGradientLayer(height: height)
        photoImageView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func createGradientLayer(withColor color: UIColor = .black, height: CGFloat) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: height))
        gradient.colors = [
            color.withAlphaComponent(0.5).cgColor,
            color.withAlphaComponent(0.3).cgColor,
            color.withAlphaComponent(0.0).cgColor
        ]
        gradient.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 0.5)
        return gradient
    }
}

// MARK: - Layout Settings
private extension PhotoCell {
    
    func addSubviews() {
        contentView.addSubview(photoImageView)
        contentView.addSubview(unsplashTitle)
    }
    
    func setupLayout() {
        photoImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.size.width.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        unsplashTitle.snp.makeConstraints {
            $0.leading.equalTo(photoImageView.snp.leading).offset(8)
            $0.bottom.equalTo(photoImageView.snp.bottom).offset(-8)
        }
    }
}
