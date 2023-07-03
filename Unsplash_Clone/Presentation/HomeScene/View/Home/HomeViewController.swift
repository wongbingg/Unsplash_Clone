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
    
    // MARK: UI Components
    private let topicCollectionView = TopicCollectionView()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.style = .large
        view.backgroundColor = .black
        view.layer.opacity = 0.7
        return view
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(
            PhotoCell.self,
            forCellReuseIdentifier: PhotoCell.identifier
        )
        return tableView
    }()
    
    private let customNavigationBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.contents = UIImage(named: "statusBar3")?.cgImage
        return view
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        button.addTarget(HomeViewController.self, action: #selector(leftBarButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let naviTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Unsplash"
        label.font = UIFont.preferredFont(for: .title3, weight: .bold)
        label.textColor = .white
        return label
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
        addSubviews()
        setConstraints()
        setupNavigationBar()
        setupTableView()
        setupTopicCollectionView()
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    // MARK: Methods
    private func setupTableView() {
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 500
        tableView.backgroundColor = .black.withAlphaComponent(0.9)
        
        viewModel.photos.bind(
            to: tableView.rx.items(
                cellIdentifier: PhotoCell.identifier,
                cellType: PhotoCell.self
            )
        ) { (row, element, cell) in
            cell.downloadPhoto(element)
//            cell.setGradientLayer()
        }
        .disposed(by: disposeBag)
    }
    
    private func setupTopicCollectionView() {
        topicCollectionView.dataSource = self
        topicCollectionView.delegate = self
        topicCollectionView.makeLayout()
    }
    
    @objc private func leftBarButtonTapped() {
        navigationController?.present(InfoViewController(), animated: true)
    }
}

// MARK: - NavigationBar Setting
private extension HomeViewController {
    
    func setupNavigationBar() {
        navigationController?.isNavigationBarHidden = true
    }
}

// MARK: - Setup Layout
private extension HomeViewController {
    
    func addSubviews() {
        view.addSubview(tableView)
        view.addSubview(customNavigationBar)
        customNavigationBar.addSubview(button)
        customNavigationBar.addSubview(naviTitle)
        customNavigationBar.addSubview(topicCollectionView)
        view.addSubview(activityIndicator)
    }
    
    func setConstraints() {
        tableView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(view.snp.top)
        }
        
        customNavigationBar.snp.makeConstraints {
            let navigationBarHeight: CGFloat = 44
            let topicCollectionViewHeight: CGFloat = 44
            let window = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
            let statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(statusBarHeight + navigationBarHeight + topicCollectionViewHeight)
        }
        
        button.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(52)
        }
        
        naviTitle.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(52)
        }
        
        topicCollectionView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(naviTitle.snp.bottom)
            $0.height.equalTo(44)
            $0.bottom.equalToSuperview().inset(8)
        }
        
        activityIndicator.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}


// MARK: - UITableViewDelegate - Photo List
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


// MARK: - UICollectionViewDataSource - TopicList
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TopicCell.identifier,
            for: indexPath
        ) as? TopicCell else {
            return UICollectionViewCell()
        }
        cell.setupData(text: Topic.allCases[indexPath.row].title)
        return cell
    }
}

// MARK: - UICollectionViewDelegate - TopicList
extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? TopicCell else {
            return
        }
        cell.setUnderBar()
        activityIndicator.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.tableView.reloadRows(at: [.init(row: 0, section: 0)], with: .none)
            self.activityIndicator.stopAnimating()
        }
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        viewModel.changeTopic(to: Topic.allCases[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? TopicCell else {
            return
        }
        cell.hideUnderBar()
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
