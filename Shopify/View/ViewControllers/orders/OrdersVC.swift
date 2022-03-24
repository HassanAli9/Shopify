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
    var noInternetimageView = UIImageView()
    
    var cartArray : [OrderItemModel] = []
    let orderViewModel = OrderViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(OrdersTVC.nib(), forCellReuseIdentifier: OrdersTVC.identifier)
        createNoInterNetConnectImage()
        setCartItems()
        setTotalPrice()
        checkCartIsEmpty()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkNetworking()
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

extension OrdersVC{
    func createNoInterNetConnectImage(){
        let image = UIImage(named: "network")
        noInternetimageView = UIImageView(image: image!)
        noInternetimageView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        noInternetimageView.center = self.view.center
        view.addSubview(noInternetimageView)
    }
}

extension OrdersVC{
    func checkNetworking(){
        Helper.shared.checkNetworkConnectionUsingRechability { isConnected in
            if !isConnected{
                self.tableView.isHidden = true
                self.emptyCart.isHidden = true
                self.noInternetimageView.isHidden = false
                self.showAlertForInterNetConnection()
            }else{
                self.emptyCart.isHidden = false
                self.tableView.isHidden = false
                self.noInternetimageView.isHidden = true
                self.setCartItems()
                self.setTotalPrice()
                self.checkCartIsEmpty()
                self.tableView.reloadData()
            }
        }
    }
}
