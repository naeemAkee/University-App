//
//  TableViewDataSource.swift
//  University App
//
//  Created by MNA Developer on 06/05/2024.
//

import UIKit

protocol TableViewDataSource: AnyObject {
    var numberOfItems: Int { get }
    func itemCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    func didSelect(tableView: UITableView, indexPath: IndexPath)
}
