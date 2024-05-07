//
//  ListInteractor.swift
//  University App
//
//  Created by MNA Developer on 06/05/2024.
//

import Foundation

protocol ListInteractorOutputs: AnyObject {
    func onSuccessSearch(res: [UniversityList])
    func onErrorSearch(error: Error)
}

final class ListInteractor : Interactorable{

    weak var presenter: ListInteractorOutputs?

    func fetchSearch() {
        let request = APIRequest.searchUAEUniversity()
        APIRequest().search(with: request, onSuccess: { [weak self] res in
            self?.presenter?.onSuccessSearch(res: res)
            print(res)
        }) { [weak self] error in
            APIRequest().fetchFromRealm { list in
                guard let newList = list else{
                    return (self?.presenter?.onErrorSearch(error: error))!
                }
                self?.presenter?.onSuccessSearch(res: newList)
            }
        }
    }
    
}
