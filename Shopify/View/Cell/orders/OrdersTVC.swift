//
//  OrdersTVC.swift
//  Shopify
//
//  Created by Hassan on 14/03/2022.
//

import UIKit

class OrdersTVC : UITableViewCell {

    
  
    
    
    static let identifier = "ordersTVC"
    
    static func nib() ->UINib{
        UINib(nibName: "OrdersTVC", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
