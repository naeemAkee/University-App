//
//  DetailPresenter.swift
//  University App
//
//  Created by MNA Developer on 06/05/2024.
//

import Foundation

typealias DetailPresenterDependencies = (
    interactor: DetailInteractor,
    router: DetailRouterOutput
)

final class DetailPresenter: Presenterable {

    internal var entities: DetailEntities
    private weak var view: DetailViewInputs!
    let dependencies: DetailPresenterDependencies

    init(entities: DetailEntities,
         view: DetailViewInputs,
         dependencies: DetailPresenterDependencies)
    {
        self.view = view
        self.entities = entities
        self.dependencies = dependencies
    }
    
}

extension DetailPresenter: DetailViewOutputs {

    func viewDidLoad() {
        view.configure(entities: entities)
        view.refreshButtonTarget(self, action: #selector(refreshButtonTapped))
        view.addCloseButtonTarget(self, action: #selector(closeButtonTapped))
    }
    
    @objc func refreshButtonTapped(){
        dependencies.router.notifyListingModuleToRefresh()
    }
    
    @objc func closeButtonTapped(){
        dependencies.router.dismiss(animated: true)
    }
    
}

extension DetailPresenter: DetailInteractorOutputs {}
