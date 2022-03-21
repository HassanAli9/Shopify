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
    
    
    @IBOutlet weak var emptyCart: UIImageView!
    
    var cartArray : [OrderItemModel] = []
    let orderViewModel = OrderViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(OrdersTVC.nib(), forCellReuseIdentifier: OrdersTVC.identifier)
       retriveCartItems()
        if cartArray.count == 0 {
            tableView.isHidden = true
            emptyCart.isHidden = false
        }
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
    
//    func updateTotalPrice(){
//        orderViewModel.getItemsInCart { cartItems, error in
//            guard let items = cartItems else {return}
//            for i in items {
//                self.totalPriceLabel.text = "33"
//            }
//        }
//        DispatchQueue.main.async {
//            self.tableView.reloadData()
//        }
//    }
    

    

}
