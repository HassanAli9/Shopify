//
//  AddressVC.swift
//  Shopify
//
//  Created by Hassan on 16/03/2022.
//

import UIKit
import SwiftUI

class AddressVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var paymentBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.register(AddressTVCell.nib(), forCellReuseIdentifier: AddressTVCell.identifier)
        paymentBtn.backgroundColor = .clear
        paymentBtn.layer.cornerRadius = 5
        paymentBtn.layer.borderWidth = 1
        paymentBtn.layer.borderColor = UIColor.tintColor.cgColor

    }
}
