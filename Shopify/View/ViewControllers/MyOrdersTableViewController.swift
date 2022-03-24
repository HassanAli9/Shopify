//
//  MyOrdersTableViewController.swift
//  myorders
//
//  Created by Omar Ahmed on 18/03/2022.
//

import UIKit

class MyOrdersTableViewController: UITableViewController {
    
    var myOrdersViewmodel = MyOrdersViewModel()
    var ordersArray : [Order] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "MyPlacedOrdersTableViewCell", bundle: nil), forCellReuseIdentifier: "myPlacedOrderCell")
        
        myOrdersViewmodel.bindSuccessToView = {
            self.onMyOrdersSucces()
        }
        
        myOrdersViewmodel.bindFailedToView = {
            self.onFailure()
        }
        
    }
    
    func onMyOrdersSucces(){
        self.ordersArray = myOrdersViewmodel.orders
        self.tableView.reloadData()
    }
    func onFailure(){
        let alert = UIAlertController(title: "Error", message: myOrdersViewmodel.showError, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ordersArray.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "My Orders"
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myPlacedOrderCell", for: indexPath) as! MyPlacedOrdersTableViewCell
        
        cell.createdAt.text = ordersArray[indexPath.row].created_at
        cell.price.text = ordersArray[indexPath.row].current_total_price?.appending("USD")
        cell.paid.text = ordersArray[indexPath.row].financial_status
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        
    }
    
    

 

}
