//
//  ProductListCell.swift
//  Shopify
//
//  Created by Islam Noureldin on 14/03/2022.
//

import UIKit

class ProductListCell: UICollectionViewCell {

    @IBOutlet weak var productView: UIView!
    @IBOutlet weak var productImageView: UIView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    static let identifier = "ProductListCell"
    
    static func nib()->UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
