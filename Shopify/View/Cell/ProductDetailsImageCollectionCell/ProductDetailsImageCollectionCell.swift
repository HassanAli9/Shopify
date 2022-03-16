//
//  ProductDetailsImageCollectionCell.swift
//  Shopify
//
//  Created by Islam Noureldin on 16/03/2022.
//

import UIKit

class ProductDetailsImageCollectionCell: UICollectionViewCell {

   
    @IBOutlet weak var productImageDetails: UIImageView!
    static let identifier = "ProductDetailsImageCollectionCell"
    
    static func nib()->UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
