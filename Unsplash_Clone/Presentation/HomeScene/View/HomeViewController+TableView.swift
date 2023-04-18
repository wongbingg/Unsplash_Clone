//
//  HomeViewController+TableView.swift
//  Unsplash_Clone
//
//  Created by 이원빈 on 2023/04/17.
//

import UIKit

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected image scale: \((tableView.cellForRow(at: indexPath) as! ImageCell).fetchCellHeight())")
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ImageCell.identifier,
            for: indexPath
        ) as? ImageCell else {
            return UITableViewCell()
        }
        cell.setupData(
            image: UIImage(named: "photo\(indexPath.row + 1)")!,
            title: "예제사진\(indexPath.row + 1)"
        )
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
