//
//  HomeViewController+CollectionView.swift
//  Unsplash_Clone
//
//  Created by 이원빈 on 2023/04/17.
//

import UIKit

// MARK: - UICollectionViewDataSource
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

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? TopicCell else {
            return
        }
        cell.setUnderBar()
        // TODO: ActivityIndicator 를 띄우고 1초뒤 해제하기
        activityIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.tableView.reloadRows(at: [.init(row: 0, section: 0)], with: .fade)
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
