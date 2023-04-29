        viewModel.photos.bind(
            to: tableView.rx.items(
                cellIdentifier: PhotoCell.identifier,
                cellType: PhotoCell.self
            )
        ) { (row, element, cell) in
            cell.downloadPhoto(element)
        }
        .disposed(by: disposeBag)
// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
        print("row \(indexPath.row) is tapped!")
    }
}
