//
//  HomeCollectionViewCell.swift
//  Shopify
//
//  Created by Nasr on 13/03/2022.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var adsImageView: UIImageView!
    static let identifier = "HomeCollectionViewCell"
    static func Nib()-> UINib{
        return UINib(nibName: "HomeCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
