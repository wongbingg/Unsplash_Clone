//
//  HomeViewController.swift
//  Unsplash_Clone
//
//  Created by 이원빈 on 2023/04/15.
//

import UIKit
import SnapKit

final class HomeViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(
            PhotoCell.self,
            forCellReuseIdentifier: PhotoCell.identifier
        )
        return tableView
    }()
    
    private lazy var categoryCollectionView = CategoryCollectionView(layout: makeLayout())
    
    // MARK: Initializers
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        setupCategoryView()
    }
    
    // MARK: Methods
    private func setupNavigationBar() {
        
        let button: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setImage(UIImage(systemName: "plus"), for: .normal)
            button.tintColor = .white
            button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            return button
        }()
        button.addTarget(self, action: #selector(leftBarButtonTapped), for: .touchUpInside)

        navigationItem.title = "Unsplash"
        navigationItem.leftBarButtonItem = .init(customView: button)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.preferredFont(for: .title3, weight: .bold)
        ]
        
        applyGradient(to: navigationController!.navigationBar)
    }
    
    private func applyGradient(to navigationBar: UINavigationBar) {
        let gradient = createGradientLayer(withColor: .black, view: navigationBar)
        navigationBar.setBackgroundImage(image(fromLayer: gradient), for: .default)
    }
    
    private func createGradientLayer(withColor color: UIColor,
                             view navigationBar: UINavigationBar) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        var frame = navigationBar.bounds
        frame.size.height += UIApplication.shared.statusBarFrame.size.height
        frame.origin.y -= UIApplication.shared.statusBarFrame.size.height
        gradient.frame = frame
        gradient.colors = [
            color.cgColor,
            color.withAlphaComponent(0.7).cgColor,
            color.withAlphaComponent(0.3).cgColor
        ]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        return gradient
    }
    
    private func image(fromLayer layer: CAGradientLayer) -> UIImage {
        UIGraphicsBeginImageContext(layer.bounds.size)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.backgroundColor = .black.withAlphaComponent(0.9)
        
        tableView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(view.snp.top)
        }
    }
    
    private func setupCategoryView() {
        view.addSubview(categoryCollectionView)
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        categoryCollectionView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.size.height.equalTo(44)
        }
    }
    
    private func makeLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = .init(width: 150, height: 44)
        return layout
    }
    
    @objc private func leftBarButtonTapped() {
        print("back button tapped")
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct HomeViewController_Preview: PreviewProvider {
    static var previews: some View {
        HomeViewController().showPreview()
    }
}
#endif
