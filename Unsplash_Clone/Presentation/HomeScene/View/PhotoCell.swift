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
    
    func downloadPhoto(_ photo: UnsplashPhoto) {
        guard let url = photo.urls[.regular] else { return }
        
        if let cachedResponse = PhotoCell.cache.cachedResponse(for: URLRequest(url: url)),
           let image = UIImage(data: cachedResponse.data) {
            photoImageView.image = image
            return
        }
        
        imageDataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
            guard let self = self else { return }
            self.imageDataTask = nil
            
            guard let data = data, let image = UIImage(data: data), error == nil else { return }
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
}
