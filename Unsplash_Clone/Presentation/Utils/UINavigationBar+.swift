//
//  UINavigationBar+.swift
//  Unsplash_Clone
//
//  Created by 이원빈 on 2023/04/23.
//

import UIKit

extension UINavigationBar {
    func toTransparent() {
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        self.isTranslucent = true
    }
}
