//
//  InfoViewController.swift
//  Unsplash_Clone
//
//  Created by 이원빈 on 2023/04/20.
//

import UIKit

final class InfoViewController: UIViewController {
    
    private let myLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Etc View"
        label.textColor = .white
        label.font = UIFont.preferredFont(for: .largeTitle, weight: .black)
        return label
    }()
    
    private let navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.isTranslucent = false
        return navigationBar
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func doneButtonTapped() {
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
        view.addSubview(navigationBar)
        view.addSubview(myLabel)
        setNavigationBar()
        navigationBar.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.size.height.equalTo(56)
        }
        
        myLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
    
    private func setNavigationBar() {
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(doneButtonTapped)
        )
        doneButton.tintColor = .white
        let navitem = UINavigationItem()
        navitem.rightBarButtonItem = doneButton
        navigationBar.items = [navitem]
        navigationBar.toTransparent()
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct InfoViewController_Preview: PreviewProvider {
    static var previews: some View {
        InfoViewController().showPreview()
    }
}
#endif

