//
//  Viewable.swift
//  University App
//
//  Created by MNA Developer on 06/05/2024.
//

import UIKit

protocol Viewable: AnyObject {
    func present(_ vc: UIViewController, animated: Bool)
    func dismiss(animated: Bool)
    func dismiss(animated: Bool, _completion:  @escaping (() -> Void))
}

extension Viewable where Self: UIViewController {

    func present(_ vc: UIViewController, animated: Bool) {
        self.present(vc, animated: animated, completion: nil)
    }

    func dismiss(animated: Bool) {
        self.dismiss(animated: animated, completion: nil)
    }

    func dismiss(animated: Bool, _completion: @escaping (() -> Void)) {
        self.dismiss(animated: animated, completion: _completion)
    }

}
