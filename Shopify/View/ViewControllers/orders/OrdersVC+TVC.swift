//
//  OrdersVC+TVC.swift
//  Shopify
//
//  Created by Hassan on 14/03/2022.
//

import Foundation
import UIKit

extension OrdersVC : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartArray.count
    }
    
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: OrdersTVC.identifier, for: indexPath) as! OrdersTVC
        cell.addButton.tag = indexPath.row
        cell.imgView.kf.setImage(with: URL(string: cartArray[indexPath.row].itemImage!))
        cell.titleLabel.text = cartArray[indexPath.row].itemName
        cell.priceLabel.text = cartArray[indexPath.row].itemPrice
        cell.quantityLabel.text = String(cartArray[indexPath.row].itemQuantity)
        cell.addButton.addAction(UIAction(handler: { _ in
            print(indexPath.row)
            print("---------------------------")
            self.cartArray[indexPath.row].itemQuantity+=1
            print(indexPath.row)
            self.tableView.reloadData()
        }), for: .touchUpInside)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at:indexPath, animated: true)
    }
    
    
}


extension OrdersVC : UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}

