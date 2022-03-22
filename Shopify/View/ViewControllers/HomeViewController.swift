//
//  HomeViewController.swift
//  Shopify
//
//  Created by Nasr on 13/03/2022.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var homeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView(){
        homeTableView.register(HomeTableViewCell.Nib(), forCellReuseIdentifier: HomeTableViewCell.identifier)
        homeTableView.register(BrandsTableViewCell.Nib(), forCellReuseIdentifier: BrandsTableViewCell.identifier)
        homeTableView.delegate = self
        homeTableView.dataSource = self
    }
    
    @IBAction func didPressedOnSearchButton(_ sender: UIBarButtonItem) {
        goToAllProduct(isCommingFromBrand: false, brandId: nil)
    }
    @IBAction func didPressedOnWishListBtn(_ sender: UIBarButtonItem) {
        Helper.shared.checkUserIsLogged { userLogged in
            if userLogged{
                self.goToWishListPage()
            }else{
                self.goToLoginPage()
            }
        }
    }
    @IBAction func didPressedOnCartBtn(_ sender: UIBarButtonItem) {
        Helper.shared.checkUserIsLogged { userLogged in
            if userLogged{
                self.goToCartPage()
            }else{
                self.goToLoginPage()
            }
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows = 0
        switch section{
        case 0:
            rows = 1
        default:
            rows = 1
        }
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let adsCell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath)
            return adsCell
        default:
            let brandCell = tableView.dequeueReusableCell(withIdentifier: BrandsTableViewCell.identifier, for: indexPath) as! BrandsTableViewCell
            brandCell.brandDelegate = self
            return brandCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = 0.0
        switch indexPath.section{
        case 0:
            height = 210
        default:
            height = view.frame.height * 1.5
        }
        return height
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title = ""
        switch section{
        case 0:
            title = ""
        default:
            title = "Brands"
        }
        return title
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "Optima", size: 24)
        header.textLabel?.textAlignment = NSTextAlignment.center
        header.textLabel?.textColor = UIColor.label
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        homeTableView.deselectRow(at: indexPath, animated: false)
    }
}

extension HomeViewController: brandIdProtocol{
    func transBrandName(brandId: Int) {
        goToAllProduct(isCommingFromBrand: true, brandId: brandId)
    }
}

extension HomeViewController{
    func goToAllProduct(isCommingFromBrand: Bool, brandId: Int?){
        let productVc = UIStoryboard(name: "ProductList", bundle: nil).instantiateViewController(withIdentifier: "ProductListVC") as! ProductListViewController
        productVc.isCommingFromBrand = isCommingFromBrand
        productVc.brandId = brandId
        self.navigationController?.pushViewController(productVc, animated: true)
    }
}

extension HomeViewController{
    func goToWishListPage(){
        let wishListVC = UIStoryboard(name: "Wishlist", bundle: nil).instantiateViewController(withIdentifier: "WishlistVC") as! WishlistVC
        self.navigationController?.pushViewController(wishListVC, animated: true)
    }
    
    func goToCartPage(){
        let cartVC = UIStoryboard(name: "orders", bundle: nil).instantiateViewController(withIdentifier: "OrdersVC") as! OrdersVC
        self.navigationController?.pushViewController(cartVC, animated: true)
    }
    
    func goToLoginPage(){
        let loginVC = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
}
