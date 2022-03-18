//
//  OrderItemCollectionViewCell.swift
//  myorders
//
//  Created by Omar Ahmed on 18/03/2022.
//

import UIKit

class MyOrderItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var orderImage: UIImageView!
    
    @IBOutlet weak var orderName: UILabel!
    
    @IBOutlet weak var orderPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
