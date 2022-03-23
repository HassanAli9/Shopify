//
//  OrderTableViewCell.swift
//  myorders
//
//  Created by Omar Ahmed on 18/03/2022.
//

import UIKit

class MyOrderTableViewCell: UITableViewCell{
    
    @IBOutlet weak var createdAt: UILabel!
    
    @IBOutlet weak var totalPrice: UILabel!
    
    @IBOutlet weak var paid: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
}
