//
//  CheckoutViewController.swift
//  Shopify
//
//  Created by Islam Noureldin on 21/03/2022.
//

import UIKit

class CheckoutViewController: UIViewController {

    var copoun : String?
    var paymentMethod : String?
    var placedOrders = [OrderItemModel]()
    var orderViewModel = OrderViewModel()
    var result = Double()
    @IBOutlet weak var checkoutTableView: UITableView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var deliveryTimeLAbel: UILabel!
    @IBOutlet weak var paymentLabel: UILabel!
    @IBOutlet weak var copounLabel: UILabel!
    @IBOutlet weak var subTotalLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var shippingLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCartItems()
        checkoutTableView.dataSource = self
        checkoutTableView.delegate = self
        checkoutTableView.register(OrdersTVC.nib(), forCellReuseIdentifier: OrdersTVC.identifier)
        discountLabel.text = copoun
        copounLabel.text = copoun!  + " discount"
        guard let totalPrice = Helper.shared.getTotalPrice() else{return}
        print("total price is \(totalPrice)")
        subTotalLabel.text = String(totalPrice)
        result = Double(String(subTotalLabel.text!))! + 10.00
        totalPriceLabel.text = String(result) + "USD"
        guard let paymentMethod = paymentMethod else {
            return
        }
        paymentLabel.text = paymentMethod

    }
    
    func setCartItems(){
        orderViewModel.getSelectedProducts { orders, error in
            guard let orders = orders else {return}
            self.placedOrders = orders
            self.checkoutTableView.reloadData()
        }
    }
    
    @IBAction func toCart(_ sender: Any) {
        let cartVC = UIStoryboard(name: "orders", bundle: nil).instantiateViewController(withIdentifier: "OrdersVC")
        navigationController?.pushViewController(cartVC, animated: false)
    }
    
    @IBAction func checkoutBtn(_ sender: Any) {
        orderViewModel.postOrder(cartArray: placedOrders)
    }
}
extension CheckoutViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placedOrders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let checkoutCell = tableView.dequeueReusableCell(withIdentifier: OrdersTVC.identifier) as! OrdersTVC
        checkoutCell.addButton.isHidden = true
        checkoutCell.subButton.isHidden = true
        checkoutCell.addToWishlist.isHidden = true
        checkoutCell.deleteProductBtn.isHidden = true
        checkoutCell.priceLabel.text = "$"+placedOrders[indexPath.row].itemPrice!
        checkoutCell.titleLabel.text = placedOrders[indexPath.row].itemName
        checkoutCell.quantityLabel.text = String(placedOrders[indexPath.row].itemQuantity)
        return checkoutCell
    }
    
    
}
extension CheckoutViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height*0.4
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
