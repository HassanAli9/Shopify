//
//  WishlistVC+TVC.swift
//  Shopify
//
//  Created by Hassan on 19/03/2022.
//

import Foundation
import UIKit

extension WishlistVC : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WishlistTVCell.identifier, for: indexPath) as! WishlistTVCell
        
        return cell
    }
    
    
}


extension WishlistVC : UITableViewDelegate
{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
}
