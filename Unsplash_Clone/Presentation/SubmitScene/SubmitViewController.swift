//
//  SubmitViewController.swift
//  Unsplash_Clone
//
//  Created by 이원빈 on 2023/04/15.
//

import UIKit

final class SubmitViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
                
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "SubmitViewController"
        
        view.addSubview(label)
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
