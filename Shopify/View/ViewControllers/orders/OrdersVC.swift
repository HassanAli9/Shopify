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
    var orderProduct : [OrderItem] = []
    var order = Order()
    let networking = Networking()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(OrdersTVC.nib(), forCellReuseIdentifier: OrdersTVC.identifier)
        setCartItems()
        //retriveCartItems()
        setTotalPrice()
        checkCartIsEmpty()
    }
    
    @IBAction func proccedToCheckout(_ sender: Any) {
        orderViewModel.postOrder(cartArray: cartArray)
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func checkCartIsEmpty(){
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
    
    func setCartItems(){
        orderViewModel.getSelectedProducts { orders, error in
            guard let orders = orders else {return}
            self.cartArray = orders
            self.tableView.reloadData()
        }
    }
    
    func setTotalPrice(){
        orderViewModel.calcTotalPrice { totalPrice in
            guard let totalPrice = totalPrice else { return }
            self.totalPriceLabel.text = String(totalPrice)
        }
    }
}
