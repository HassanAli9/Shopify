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
    @IBOutlet weak var noItemsLabel: UILabel!
    let wishListViewModel = WishListViewModel()
    var arrOfWishListProducts: [WishListModel] = []
    var noInternetimageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        createNoInterNetConnectImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkNetworking()
    }
}

extension WishlistVC{
    func checkIsWishListIsEmpty(){
        if self.arrOfWishListProducts.count == 0 {
            self.tableView.isHidden = true
            self.noItemsLabel.isHidden = false
            self.noFoundImageView.isHidden = false
        }else{
            self.tableView.isHidden = false
            self.noItemsLabel.isHidden = true
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

extension WishlistVC{
    func createNoInterNetConnectImage(){
        let image = UIImage(named: "network")
        noInternetimageView = UIImageView(image: image!)
        noInternetimageView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        noInternetimageView.center = self.view.center
        view.addSubview(noInternetimageView)
    }
}

extension WishlistVC{
    func checkNetworking(){
        Helper.shared.checkNetworkConnectionUsingRechability { isConnected in
            if !isConnected{
                self.tableView.isHidden = true
                self.noFoundImageView.isHidden = true
                self.noInternetimageView.isHidden = false
                self.showAlertForInterNetConnection()
            }else{
                self.noFoundImageView.isHidden = false
                self.tableView.isHidden = false
                self.noInternetimageView.isHidden = true
                self.setWishListProducts()
                self.checkIsWishListIsEmpty()
                self.tableView.reloadData()
            }
        }
    }
}
