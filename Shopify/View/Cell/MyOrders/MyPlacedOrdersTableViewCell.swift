//
//  MyPlacedOrdersTableViewCell.swift
//  Shopify
//
//  Created by Omar Ahmed on 24/03/2022.
//

import UIKit

class MyPlacedOrdersTableViewCell: UITableViewCell {
    @IBOutlet weak var createdAt: UILabel!
    
    @IBOutlet weak var paid: UILabel!
    @IBOutlet weak var price: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
