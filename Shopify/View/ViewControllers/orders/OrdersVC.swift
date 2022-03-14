//
//  OrdersVC.swift
//  Shopify
//
//  Created by Hassan on 14/03/2022.
//

import UIKit

class OrdersVC: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(OrdersTVC.nib(), forCellReuseIdentifier: OrdersTVC.identifier)
    }
    

    

}
