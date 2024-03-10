//
//  TableViewCell.swift
//  customTableView
//
//  Created by abdullah on 10.03.2024.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    
    // MARK: - Decleration


    @IBOutlet var symbolLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    func update(with emoji: Emoji)
    {
        symbolLabel.text = emoji.symbol
        nameLabel.text = emoji.name
        descriptionLabel.text = emoji.description
        
    }

}
