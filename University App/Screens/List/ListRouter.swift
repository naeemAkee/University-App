//
//  ListRouter.swift
//  University App
//
//  Created by MNA Developer on 06/05/2024.
//

import UIKit


struct ListRouterInput {

    private func view(item: UniversityList) -> ListViewController {
        let view = ListViewController()
        let interactor = ListInteractor()
        let dependencies = ListPresenterDependencies(interactor: interactor, router: ListRouterOutput(view, interactor: interactor))
        let presenter = ListPresenter(entities: ListEntities(item: item), view: view, dependencies: dependencies)
        view.presenter = presenter
        view.tableViewDataSource = ListTableViewDataSource(entities: presenter.entities, presenter: presenter)
        interactor.presenter = presenter
        return view
    }

    func present(from: Viewable, item: UniversityList) {
        let detailViewController = view(item: item)
        detailViewController.modalPresentationStyle = .fullScreen
        from.present(detailViewController, animated: true)
    }
    
}

final class ListRouterOutput: Routerable, DetailRouterDelegate {
    

    internal weak var view: Viewable!
    private let interactor: ListInteractor

    init(_ view: Viewable, interactor: ListInteractor) {
        self.view = view
        self.interactor = interactor
    }

    func transitionDetail(item: UniversityList) {
        
        let detailRouterInput = DetailRouterInput()
        let detailRouterOutput = DetailRouterOutput(view)
        detailRouterOutput.delegate = self
        detailRouterInput.present(from: view, item: item, detailRouterOutput: detailRouterOutput)
    }
    
    func notifyListingModuleToRefresh() {
        interactor.fetchSearch()
    }

}


