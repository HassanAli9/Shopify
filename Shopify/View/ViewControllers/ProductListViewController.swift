//
//  ProductListViewController.swift
//  Shopify
//
//  Created by Islam Noureldin on 14/03/2022.
//

import UIKit
import Kingfisher

class ProductListViewController: UIViewController{
   
    var isCommingFromBrand: Bool = false
    var brandName: String?
    var products = [Product]()
    var productsViewModel = ProductViewModel()
    var filteredProducts : [Product]!
    var filterIsPressed = true
    var isFiltered = false
    @IBOutlet weak var minimumPrice: UILabel!
    @IBOutlet weak var maximumPrice: UILabel!
    @IBOutlet weak var priceSlider: UISlider!
    @IBOutlet weak var productSearchbar: UISearchBar!
    @IBOutlet weak var productListCollectionView: UICollectionView!
    
    @IBAction func sortByPrice(_ sender: UISlider) {
        print(sender.value)
        isFiltered = true
        let filteredByPrice = self.products.filter { product in
            maximumPrice.text = String(Int(sender.value)) + "$"
            return Float(product.variants?[0].price ?? "") ?? 0 <= sender.value
    }
       
            self.filteredProducts = filteredByPrice
            self.updateUi()
        
    }
    
    @IBAction func toWishlistBtn(_ sender: Any) {
        goToWishListPage()
    }
    
    @IBAction func filterBtnByPrice(_ sender: Any) {
        
        filterBtnIsPressed()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        maximumPrice.isHidden = true
        minimumPrice.isHidden = true
        priceSlider.isHidden = true
        setupProductCollection()
        setProducts()
        filteredProducts = products
    }
    
   private func setupProductCollection(){
        productListCollectionView.delegate = self
        productListCollectionView.dataSource = self
        productSearchbar.delegate = self
        productListCollectionView.register(ProductListCell.nib(), forCellWithReuseIdentifier: ProductListCell.identifier)
    }
    
    private func setProducts(){
        productsViewModel.bindSuccessToView = {
        self.products = self.productsViewModel.products
        self.updateUi()
        }
        
        productsViewModel.bindFailedToView = {
            print("error in setting data to View")
        }
    }
    
    private func updateUi(){
        DispatchQueue.main.async {
        self.productListCollectionView.reloadData()
        }
    }
    
    private func filterBtnIsPressed(){
        if filterIsPressed{
            filterIsPressed = false
            minimumPrice.isHidden = false
            maximumPrice.isHidden = false
            priceSlider.isHidden = false
        }else{
            minimumPrice.isHidden = true
            maximumPrice.isHidden = true
            filterIsPressed = true
            priceSlider.isHidden = true
        }
    }

}
// MARK :- CollectionView
extension ProductListViewController:UISearchBarDelegate,UICollectionViewDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !isFiltered {
            return products.count
        }else{
            return filteredProducts.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let productCell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductListCell.identifier, for: indexPath) as! ProductListCell
        if filteredProducts.count != 0{
            productCell.productNameLabel.text = filteredProducts[indexPath.row].title
            productCell.productImageView.kf.setImage(with: URL(string: filteredProducts[indexPath.row].image?.src ?? ""))
            productCell.productImageView.kf.indicatorType = .activity
            if  let variant = filteredProducts[indexPath.row].variants, let price = variant[0].price {
                productCell.productPriceLabel.text = price + "$"
            }
        }else{
        productCell.productNameLabel.text = products[indexPath.row].title
        productCell.productImageView.kf.setImage(with: URL(string: products[indexPath.row].image?.src ?? ""))
            productCell.productImageView.kf.indicatorType = .activity
        if  let variant = products[indexPath.row].variants, let price = variant[0].price {
            productCell.productPriceLabel.text = price + " $"
        }
        }
        return productCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width*0.44, height: self.view.frame.width*0.6)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("did select cell")

         let product = products[indexPath.row]
        let productDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
        productDetailsVC.product = product
        self.navigationController?.pushViewController(productDetailsVC, animated: true)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            isFiltered = true
        }

        func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
            isFiltered = false
        }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredProducts = []
        if searchText == ""{
            filteredProducts = products
        }else{
           
            for product in products{
                guard let title = product.title else{return}
                if title.hasPrefix(searchText) || title.hasPrefix(searchText.uppercased()){
                    filteredProducts.append(product)
                }
            }
        }
        self.updateUi()
    }
    
}

extension ProductListViewController{
    func goToWishListPage(){
        let wishListVC = UIStoryboard(name: "Wishlist", bundle: nil).instantiateViewController(withIdentifier: "WishlistVC") as! WishlistVC
        self.navigationController?.pushViewController(wishListVC, animated: true)
    }
}
