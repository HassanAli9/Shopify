//
//  ProductInCategoryCVC.swift
//  Shopify
//
//  Created by Omar Ahmed on 14/03/2022.
//

import UIKit

protocol ProductInCategoryProtocol{
    func addProductToWishList(row: Int, sender: UIButton) -> Void
}

class ProductInCategoryCVC: UICollectionViewCell {

    @IBOutlet weak var productPriceCat: UILabel!
    @IBOutlet weak var productNameCat: UILabel!
    @IBOutlet weak var productImgViewCat: UIImageView!
    @IBOutlet weak var favView: UIView!
    @IBOutlet weak var favButton: UIButton!
    var row = 0
    var delegate: ProductInCategoryProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func didPressedOnFavBtn(_ sender: UIButton) {
        delegate?.addProductToWishList(row: row, sender: sender)
    }
}
