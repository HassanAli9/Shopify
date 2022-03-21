//
//  ProductInCategoryCVC.swift
//  Shopify
//
//  Created by Omar Ahmed on 14/03/2022.
//

import UIKit

class ProductInCategoryCVC: UICollectionViewCell {

    @IBOutlet weak var productPriceCat: UILabel!
    @IBOutlet weak var productNameCat: UILabel!
    @IBOutlet weak var productImgViewCat: UIImageView!
    @IBOutlet weak var favView: UIView!
    @IBOutlet weak var favButton: UIButton!
    var addToWishList: (()->())?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        favButton.setImage(UIImage(systemName: "heart"), for: .normal)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func didPressedOnFavBtn(_ sender: UIButton) {
        addToWishList?()
    }
}
