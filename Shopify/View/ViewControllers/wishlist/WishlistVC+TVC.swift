//
//  WishlistVC+TVC.swift
//  Shopify
//
//  Created by Hassan on 19/03/2022.
//

import Foundation
import UIKit
import Kingfisher

extension WishlistVC : UITableViewDataSource{
    
    func setupTableView(){
        tableView.register(WishlistTVCell.nib(), forCellReuseIdentifier: WishlistTVCell.identifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrOfWishListProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WishlistTVCell.identifier, for: indexPath) as! WishlistTVCell
        let selectedProduct = arrOfWishListProducts[indexPath.row]
        cell.titleLable.text = selectedProduct.productName
        cell.priceLable.text = selectedProduct.productPrice
        cell.imgView.kf.indicatorType = .activity
        if let productImageStr = selectedProduct.productImage{
            cell.imgView.kf.setImage(with: URL(string: productImageStr))
        }
        return cell
    }
}

extension WishlistVC : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}
