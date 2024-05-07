//
//  ListTableViewDataSource.swift
//  University App
//
//  Created by MNA Developer on 06/05/2024.
//

import UIKit

protocol ListTableViewDataSourceOutputs: AnyObject {
    func didSelect(_ list: UniversityList)
}

final class ListTableViewDataSource: TableViewDataSource {

    private weak var entities: ListEntities!
    private weak var presenter: ListTableViewDataSourceOutputs?

    init(entities: ListEntities, presenter: ListTableViewDataSourceOutputs) {
        self.entities = entities
        self.presenter = presenter
    }

    var numberOfItems: Int {
        return entities.universityList.count
    }

    func itemCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as? ListTableViewCell else {
            return UITableViewCell()
        }
        let item = entities.universityList[indexPath.row]
        cell.setupCell(item: item)
        return cell
    }

    func didSelect(tableView: UITableView, indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedItem = entities.universityList[indexPath.row]
        presenter?.didSelect(selectedItem)
    }

}
