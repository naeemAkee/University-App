//
//  DetailViewController.swift
//  University App
//
//  Created by MNA Developer on 06/05/2024.
//

import UIKit

protocol DetailViewInputs: AnyObject {
    func configure(entities: DetailEntities)
    func refreshButtonTarget(_ target: Any, action: Selector)
    func addCloseButtonTarget(_ target: Any, action: Selector)
}

protocol DetailViewOutputs: AnyObject {
    func viewDidLoad()
}

class DetailViewController: UIViewController {
    
    @IBOutlet weak var universityNameLabel: UILabel!
    @IBOutlet weak var universityStateLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var countryCodeLabel: UILabel!
    @IBOutlet weak var webPageLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    internal var presenter: DetailViewOutputs?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
}


extension DetailViewController: DetailViewInputs {
    
    func configure(entities: DetailEntities) {
        universityNameLabel.text = entities.item.name
        universityStateLabel.text = entities.item.country
        countryLabel.text = entities.item.country
        countryCodeLabel.text = entities.item.alphaTwoCode
        webPageLabel.text = entities.item.webPages.first
    }
    
    func refreshButtonTarget(_ target: Any, action: Selector) {
        refreshButton.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func addCloseButtonTarget(_ target: Any, action: Selector) {
        closeButton.addTarget(target, action: action, for: .touchUpInside)
    }
}

extension DetailViewController: Viewable {}

