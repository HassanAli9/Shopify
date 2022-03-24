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
    var arrOfAddress: [Address] = []
    let addressViewModel = AddressViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(AddressTVCell.nib(), forCellReuseIdentifier: AddressTVCell.identifier)
        setAddress()
    }
    
    func setAddress(){
        addressViewModel.bindSuccessToView = {
            self.arrOfAddress = self.addressViewModel.address
            self.tableView.reloadData()
        }
        
        addressViewModel.bindFailedToView = {
            print("erro when get address")
        }
    }
}
