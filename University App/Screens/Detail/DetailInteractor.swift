//
//  DetailInteractor.swift
//  University App
//
//  Created by MNA Developer on 06/05/2024.
//

import Foundation

protocol DetailInteractorOutputs: AnyObject {

}

final class DetailInteractor: Interactorable {
    weak var presenter: DetailInteractorOutputs?
}

