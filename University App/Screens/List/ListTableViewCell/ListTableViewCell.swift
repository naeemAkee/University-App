//
//  ListTableViewCell.swift
//  University App
//
//  Created by MNA Developer on 07/05/2024.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var universityNameLabel: UILabel!
    @IBOutlet weak var universityStateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupCell(item: UniversityList){
        universityNameLabel.text = item.name
        universityStateLabel.text = item.country
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
