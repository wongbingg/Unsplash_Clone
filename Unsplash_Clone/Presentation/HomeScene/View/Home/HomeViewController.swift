//
//  HomeViewController.swift
//  Unsplash_Clone
//
//  Created by 이원빈 on 2023/04/15.
//

import UIKit
import SnapKit
import UnsplashPhotoPicker
import RxSwift
import RxRelay

final class HomeViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private(set) var viewModel = DefaultHomeViewModel()
    private lazy var topicCollectionView = TopicCollectionView(layout: makeLayout())
    
    let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.style = .large
        view.backgroundColor = .systemRed
//        view.tintColor = .systemBackground
        return view
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(
            PhotoCell.self,
            forCellReuseIdentifier: PhotoCell.identifier
        )
        return tableView
    }()
    
    // MARK: Initializers
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        setupTopicCollectionView()
        viewModel.viewDidLoad()
    }
    
    // MARK: Methods
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
//        tableView.prefetchDataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 500
        tableView.backgroundColor = .black.withAlphaComponent(0.9)
        
        tableView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(view.snp.top)
        }
        
        viewModel.photos.bind(
            to: tableView.rx.items(
                cellIdentifier: PhotoCell.identifier,
                cellType: PhotoCell.self
            )
        ) { (row, element, cell) in
            cell.downloadPhoto(element)
        }
        .disposed(by: disposeBag)
    }
    
    private func setupTopicCollectionView() {
        view.addSubview(topicCollectionView)
        view.addSubview(activityIndicator)
        topicCollectionView.dataSource = self
        topicCollectionView.delegate = self
        topicCollectionView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.size.height.equalTo(44)
        }
        activityIndicator.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func makeLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = .init(width: 150, height: 44)
        return layout
    }
    
    @objc private func leftBarButtonTapped() {
//        navigationController?.present(InfoViewController(), animated: true)
//        tableView.reloadRows(at: [.init(row: 0, section: 0)], with: .fade)
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
        print("row \(indexPath.row) is tapped!")
        let vc = DetailViewContoller(
            name: viewModel.photos.value[indexPath.row].user.name ?? "unknown"
        )
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indeddxPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - UITableViewDataSourcePrefetching
// TODO: - 적용해보기
//extension HomeViewController: UITableViewDataSourcePrefetching {
//
//    func tableView(_ tableView: UITableView,
//                   prefetchRowsAt indexPaths: [IndexPath]) {
//        for indexPath in indexPaths {
//            if let cell = tableView.dequeueReusableCell(
//                withIdentifier: PhotoCell.identifier,
//                for: indexPath
//            ) as? PhotoCell {
//                let f = viewModel.photos.value[indexPath.row]
//                cell.downloadPhoto(f)
//                print("미리받아오기 \(f.user.name)")ddds
//            }
//        }
//    }dss
//}

// MARK: - NavigationBar Settingssd
private extension HomeViewController {
    
    func setupNavigationBar() {
        
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
        
        applyGradient(to: navigationController?.navigationBar)
    }
    
    func applyGradient(to navigationBar: UINavigationBar?) {
        guard let navigationBar = navigationBar else { return }
        let gradient = createGradientLayer(withColor: .black, view: navigationBar)
        navigationBar.setBackgroundImage(
            UIImage().adopt(fromLayer: gradient),
            for: .default
        )
    }
    
    func createGradientLayer(withColor color: UIColor,
                             view navigationBar: UINavigationBar) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        var frame = navigationBar.bounds
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return gradient
        }
        frame.size.height += windowScene.statusBarManager?.statusBarFrame.size.height ?? 0.0
        frame.origin.y -= windowScene.statusBarManager?.statusBarFrame.size.height ?? 0.0
        gradient.frame = frame
        gradient.colors = [
            color.withAlphaComponent(0.9).cgColor,
            color.withAlphaComponent(0.7).cgColor,
            color.withAlphaComponent(0.4).cgColor
        ]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        return gradient
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
