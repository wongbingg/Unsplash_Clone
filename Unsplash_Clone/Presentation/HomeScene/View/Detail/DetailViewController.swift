//
//  DetailViewController.swift
//  Unsplash_Clone
//
//  Created by 이원빈 on 2023/04/29.
//

import UIKit

final class DetailViewContoller: UIViewController {
    private let userName: String
    
    init(name: String) {
        self.userName = name
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        let shareButton: UIButton = {
            let button = UIButton()
            button.tintColor = .white
            button.setImage(
                UIImage(systemName: "square.and.arrow.up")?
                    .applyingSymbolConfiguration(.init(weight: .bold)),
                for: .normal
            )
            button.addTarget(
                self,
                action: #selector(shareButtonTapped),
                for: .touchUpInside
            )
            return button
        }()
        
        let backButton: UIButton = {
            let button = UIButton()
            button.tintColor = .white
            button.setImage(
                UIImage(systemName: "chevron.backward")?
                    .applyingSymbolConfiguration(.init(weight: .bold)),
                for: .normal
            )
            button.addTarget(
                self,
                action: #selector(backButtonTapped),
                for: .touchUpInside
            )
            return button
        }()
        navigationItem.rightBarButtonItem = .init(customView: shareButton)
        navigationItem.leftBarButtonItem = .init(customView: backButton)
        navigationItem.title = userName
    }
    
    @objc private func shareButtonTapped() {
        print(#function)
    }
    
    @objc private func backButtonTapped() {
        print(#function)
        navigationController?.popViewController(animated: true)
    }
}
