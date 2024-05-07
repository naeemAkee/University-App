//
//  ListViewController.swift
//  University App
//
//  Created by MNA Developer on 06/05/2024.
//

import UIKit
import RealmSwift

protocol ListViewInputs: AnyObject {
    func configure(entities: ListEntities)
    func reloadTableView(tableViewDataSource: ListTableViewDataSource)
}

protocol ListViewOutputs: AnyObject {
    func viewDidLoad()
}

class ListViewController: UIViewController {
    
    internal var presenter: ListViewOutputs?
    internal var tableViewDataSource: TableViewDataSource?

    @IBOutlet weak var universityTableView: UITableView!{
        didSet{
            universityTableView.delegate = self
            universityTableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        
        let nib = UINib(nibName: "ListTableViewCell", bundle: nil)
        universityTableView.register(nib, forCellReuseIdentifier: "ListTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
}

extension ListViewController: ListViewInputs {

    func configure(entities: ListEntities) {
        navigationItem.title = entities.item.name ?? ""
    }

    func reloadTableView(tableViewDataSource: ListTableViewDataSource) {
        DispatchQueue.main.async { [weak self] in
            self?.tableViewDataSource = tableViewDataSource
            self?.universityTableView.reloadData()
        }
    }
    
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewDataSource?.numberOfItems ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableViewDataSource?.itemCell(tableView: tableView, indexPath: indexPath) ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        tableViewDataSource?.didSelect(tableView: tableView, indexPath: indexPath)
    }

}

extension ListViewController: Viewable {}
