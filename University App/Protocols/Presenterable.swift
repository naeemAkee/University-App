//
//  Presenterable.swift
//  University App
//
//  Created by MNA Developer on 06/05/2024.
//

import Foundation

protocol Presenterable {
    associatedtype I: Interactorable
    associatedtype R: Routerable
    var dependencies: (interactor: I, router: R) { get }
}


