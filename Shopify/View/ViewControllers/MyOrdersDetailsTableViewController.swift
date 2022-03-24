//
//  MyOrdersDetailsTableViewController.swift
//  Shopify
//
//  Created by Omar Ahmed on 24/03/2022.
//

import UIKit

class MyOrdersDetailsTableViewController: UITableViewController {
    
    var comingOrder : [OrderItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "MyOrderItemCollectionViewCell", bundle: nil), forCellReuseIdentifier: "myorderitemCell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return comingOrder.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myorderitemCell", for: indexPath) as! MyOrderItemCollectionViewCell
        
        cell.orderName.text = comingOrder[indexPath.row].title
        cell.orderPrice.text = comingOrder[indexPath.row].price

        return cell
    }
    
}
