//
//  AddressTVCell.swift
//  Shopify
//
//  Created by Hassan on 16/03/2022.
//

import UIKit
import MBRadioButton

class AddressTVCell: UITableViewCell {

    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var radioBtn: RadioButton!
    
    static let identifier = "addressTVCell"

    var actionBlock: (() -> Void)? = nil

    static func nib() -> UINib{
     return UINib(nibName: "AddressTVCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addressLabel.text = "Salmiya, King sabah street, building56,\nfloor2"
        
    }

    @objc func btn (num:Int)
    {
        radioBtn.isSelected = false
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func radioAction(_ sender: Any) {
        
        actionBlock?()
    }
    
    
}
