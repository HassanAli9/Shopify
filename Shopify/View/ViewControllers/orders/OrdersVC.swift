//
//  OrdersVC.swift
//  Shopify
//
//  Created by Hassan on 14/03/2022.
//

import UIKit

class OrdersVC: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
  
    
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    var cartArray : [OrderItemModel] = []
    let orderViewModel = OrderViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(OrdersTVC.nib(), forCellReuseIdentifier: OrdersTVC.identifier)
       retriveCartItems()
    }
    
    
    func retriveCartItems(){
        orderViewModel.getItemsInCart { cartItems, error in
            guard let items = cartItems else {return}
            self.cartArray = items
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    

    

}
