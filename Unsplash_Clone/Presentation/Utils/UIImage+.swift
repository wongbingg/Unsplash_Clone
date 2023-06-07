//
//  UIImage+.swift
//  Unsplash_Clone
//
//  Created by 이원빈 on 2023/04/16.
//

import UIKit

extension UIImage {
    func resizeTo(newWidth: CGFloat) -> UIImage {
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        
        let size = CGSize(width: newWidth, height: newHeight)
        let render = UIGraphicsImageRenderer(size: size)
        let renderImage = render.image { context in
            self.draw(in: .init(origin: .zero, size: size))
        }
        
        return renderImage
    }
    
    func adopt(fromLayer layer: CAGradientLayer) -> UIImage {
        UIGraphicsBeginImageContext(layer.bounds.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            return UIImage()
        }
        layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
