//
//  DetailRouter.swift
//  University App
//
//  Created by MNA Developer on 06/05/2024.
//

import UIKit

protocol DetailRouterDelegate: AnyObject {
    func notifyListingModuleToRefresh()
}

final class DetailRouterInput {
    private func view(item: UniversityList, detailRouterOutput: DetailRouterOutput) -> DetailViewController {
        let view = DetailViewController()
        let interactor = DetailInteractor()
        let dependencies = DetailPresenterDependencies(interactor: interactor, router: detailRouterOutput)
        let presenter = DetailPresenter(entities: DetailEntities(item: item), view: view, dependencies: dependencies)
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }

    func present(from: Viewable, item: UniversityList, detailRouterOutput: DetailRouterOutput) {
        let view = self.view(item: item, detailRouterOutput: detailRouterOutput)
        view.modalPresentationStyle = .fullScreen
        from.present(view, animated: true)
    }

}

final class DetailRouterOutput: Routerable {
    private(set) weak var view: Viewable!
    weak var delegate: DetailRouterDelegate?
    weak var viewController: UIViewController?

    init(_ view: Viewable) {
        self.view = view
    }
    
    func notifyListingModuleToRefresh() {
        delegate?.notifyListingModuleToRefresh()
    }
    
    func dismissScreen(detailRouterOutput: DetailRouterOutput) {
        detailRouterOutput.viewController?.dismiss(animated: true)
    }
}

