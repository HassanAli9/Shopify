//
//  WishlistTVCell.swift
//  Shopify
//
//  Created by Hassan on 19/03/2022.
//

import UIKit

class WishlistTVCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var titleLable: UILabel!
    
    @IBOutlet weak var priceLable: UILabel!
    
    
    
    static let identifier = "wishlistTVCell"
    
    static func nib() ->UINib{
        UINib(nibName: "WishlistTVCell", bundle: nil)
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
