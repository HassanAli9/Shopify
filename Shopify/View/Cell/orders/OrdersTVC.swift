//
//  OrdersTVC.swift
//  Shopify
//
//  Created by Hassan on 14/03/2022.
//

import UIKit

class OrdersTVC : UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    
  
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var priceLabel: UILabel!
   
    
    @IBOutlet weak var quantityLabel: UILabel!
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var subButton: UIButton!
    
    static let identifier = "ordersTVC"
    
    var addItemQuantity : (()->())?
    var subItemQuantity : (()->())?
    
    static func nib() ->UINib{
        UINib(nibName: "OrdersTVC", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    @IBAction func addQuantity(_ sender: Any) {
        print("add")
        addItemQuantity?()
    }
    
    @IBAction func subQuantity(_ sender: Any) {
        subItemQuantity?()
    }
    
    
    
}
