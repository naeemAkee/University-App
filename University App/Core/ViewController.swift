//
//  ViewController.swift
//  University App
//
//  Created by MNA Developer on 06/05/2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async { [weak self] in
            let item = UniversityList()
            ListRouterInput().present(from: self!, item: item)
        }
    }

}

extension ViewController: Viewable {}
