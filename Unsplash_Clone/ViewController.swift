//
//  ViewController.swift
//  Unsplash_Clone
//
//  Created by 이원빈 on 2023/04/14.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.text = "Preview Tests"
        text.textColor = .black
        view.addSubview(text)
        text.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        text.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct ViewController_Preview: PreviewProvider {
    static var previews: some View {
        ViewController().showPreview()
    }
}
#endif
