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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            self.showConfirmAlert(title: "Do you want to delete this product ??", message: "Product that is deleted can not return again!!") { confirmDeleted in
                if confirmDeleted{
                    //delete product
                    let product = self.arrOfWishListProducts[indexPath.row]
                    self.wishListViewModel.deletedProduct(product: product) { deletedSuccess in
                        if deletedSuccess{
                            print("deleted success")
                            tableView.beginUpdates()
                            tableView.deleteRows(at: [indexPath], with: .automatic)
                            self.arrOfWishListProducts.remove(at: indexPath.row)
                            tableView.endUpdates()
                            self.checkIsWishListIsEmpty()
                        }else{
                            print("deleted failed")
                        }
                    }
                }
            }
        }
    }
}
