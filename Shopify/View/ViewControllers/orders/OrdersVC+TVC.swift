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
        return 3
    }
    
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: OrdersTVC.identifier, for: indexPath) as! OrdersTVC
        
        return cell
    }
    
    
}


extension OrdersVC : UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

