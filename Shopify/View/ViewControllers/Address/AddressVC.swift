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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
