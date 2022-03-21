//
//  WishlistVC.swift
//  Shopify
//
//  Created by Hassan on 19/03/2022.
//

import UIKit

class WishlistVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noFoundImageView: UIImageView!
    let wishListViewModel = WishListViewModel()
    var arrOfWishListProducts: [WishListModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setWishListProducts()
        checkIsWishListIsEmpty()
    }
}

extension WishlistVC{
    func checkIsWishListIsEmpty(){
        if self.arrOfWishListProducts.count == 0 {
            self.tableView.isHidden = true
            self.noFoundImageView.isHidden = false
        }else{
            self.tableView.isHidden = false
            self.noFoundImageView.isHidden = true
        }
    }
}
extension WishlistVC{
    func setWishListProducts(){
        wishListViewModel.getSelectedProducts { wishlistProducts, error in
            guard let wishlistProducts = wishlistProducts else {return}
            self.arrOfWishListProducts = wishlistProducts
            self.tableView.reloadData()
        }
    }
}
