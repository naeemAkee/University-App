//
//  ListPresenter.swift
//  University App
//
//  Created by MNA Developer on 06/05/2024.
//

import Foundation

typealias ListPresenterDependencies = (
    interactor: ListInteractor,
    router: ListRouterOutput
)

final class ListPresenter: Presenterable {
    internal var entities: ListEntities
    private weak var view: ListViewInputs!
    let dependencies: ListPresenterDependencies

    init(entities: ListEntities,
         view: ListViewInputs,
         dependencies: ListPresenterDependencies)
    {
        self.view = view
        self.entities = entities
        self.dependencies = dependencies
    }

}

extension ListPresenter: ListViewOutputs {
    func viewDidLoad() {
        view.configure(entities: entities)
        dependencies.interactor.fetchSearch()
    }
}

extension ListPresenter: ListInteractorOutputs {
    func onSuccessSearch(res: [UniversityList]) {
        entities.universityList = res
        view.reloadTableView(tableViewDataSource: ListTableViewDataSource(entities: entities, presenter: self))
    }

    func onErrorSearch(error: Error) {
    }

}

extension ListPresenter: ListTableViewDataSourceOutputs {
    func didSelect(_ list: UniversityList) {
        dependencies.router.transitionDetail(item: list)
    }
}
