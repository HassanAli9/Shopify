//
//  ProductListViewController.swift
//  Shopify
//
//  Created by Islam Noureldin on 14/03/2022.
//

import UIKit
import Kingfisher

class ProductListViewController: UIViewController{
   
    

    var products = [Product]()
    var productsViewModel = ProductViewModel()
    var filteredProducts : [Product]!
    var isFiltered = false
    @IBOutlet weak var productSearchbar: UISearchBar!
    @IBOutlet weak var productListCollectionView: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

}

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
