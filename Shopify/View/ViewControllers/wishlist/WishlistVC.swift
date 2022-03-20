//
//  WishlistVC.swift
//  Shopify
//
//  Created by Hassan on 19/03/2022.
//

import UIKit

class WishlistVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let wishListViewModel = WishListViewModel()
    var arrOfWishListProducts: [WishListModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setWishListProducts()
    }
}

extension WishlistVC{
    func setWishListProducts(){
        wishListViewModel.getProductFromWishList { wishlistProducts, error in
            guard let wishlistProducts = wishlistProducts else {
                return
            }
            self.arrOfWishListProducts = wishlistProducts
            self.tableView.reloadData()
        }
    }
}
