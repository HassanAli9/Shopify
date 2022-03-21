//
//  ProductListViewController.swift
//  Shopify
//
//  Created by Islam Noureldin on 14/03/2022.
//

import UIKit
import Kingfisher

class ProductListViewController: UIViewController{
    var isCommingFromBrand = false
    var brandId: Int?
    var originalProducts = [Product]()
    var productsViewModel = ProductViewModel()
    var filteredProducts : [Product]!
    var filterIsPressed = true
    var isFiltered = false
    var isSortedPressed = true
    
    @IBOutlet weak var minimumPrice: UILabel!
    @IBOutlet weak var maximumPrice: UILabel!
    @IBOutlet weak var priceSlider: UISlider!
    @IBOutlet weak var productSearchbar: UISearchBar!
    @IBOutlet weak var productListCollectionView: UICollectionView!
    
    @IBOutlet weak var notFoundImage: UIImageView!
    
    @IBAction func filterSlider(_ sender: UISlider) {
        print(sender.value)
        isFiltered = true
        let filteredByPrice = self.originalProducts.filter { product in
            maximumPrice.text = "$"+String(Int(sender.value))
            return Float(product.variants?[0].price ?? "") ?? 0 <= sender.value
        }
            self.filteredProducts = filteredByPrice
        self.updateUi()
    }
    
    @IBAction func toWishlistBtn(_ sender: Any) {
        Helper.shared.checkUserIsLogged { userLogged in
            if userLogged{
                self.goToWishListPage()
            }else{
                self.goToLoginPage()
            }
        }
    }
    
    @IBAction func toCartBtn(_ sender: Any) {
        let cartVC = UIStoryboard(name: "orders", bundle: nil).instantiateViewController(withIdentifier: "OrdersVC")
        navigationController?.pushViewController(cartVC, animated: false)
    }
    
    @IBAction func filterBtnByPrice(_ sender: Any) {
        filterBtnIsPressed()
    }
    
    @IBAction func sortByPriceButton(_ sender: Any) {
        if isSortedPressed{
            isSortedPressed = false
            filteredProducts = originalProducts.sorted(by: {
                Double($0.variants![0].price!)! < Double($1.variants![0].price!)!
            })
            self.updateUi()
        }else{
            isSortedPressed = true
            filteredProducts = originalProducts.sorted(by: {
                Double($0.variants![0].price!)! > Double($1.variants![0].price!)!
            })
            self.updateUi()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        maximumPrice.isHidden = true
        minimumPrice.isHidden = true
        priceSlider.isHidden = true
        notFoundImage.isHidden = true
        setupProductCollection()
        filteredProducts = originalProducts
 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let collectionId = brandId {
            getBrandsProducs(cID: collectionId)
        }else{
            getAllProducts()
        }
    }
   private func setupProductCollection(){
        productListCollectionView.delegate = self
        productListCollectionView.dataSource = self
        productSearchbar.delegate = self
        productListCollectionView.register(ProductListCell.nib(), forCellWithReuseIdentifier: ProductListCell.identifier)
    }
    
    private func getAllProducts(){
        productsViewModel.bindSuccessToView = {
            guard let products = self.productsViewModel.products else{return}
        self.originalProducts = products
        self.filteredProducts = products
        self.updateUi()
        }
        productsViewModel.bindFailedToView = {
            print("error in setting data to View")
        }
    }
    
    func getBrandsProducs(cID:Int){
        productsViewModel.getProductsfromAPI(collectioID: cID, complition: { products, error in
            if let productsList = products {
                self.filteredProducts=productsList.products!
                self.updateUi()
            }else{
               print("error")
            }
        })
        
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

// MARK: CollectionView DataSorce
extension ProductListViewController: UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let productCell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductListCell.identifier, for: indexPath) as! ProductListCell
            
            self.notFoundImage.isHidden = true
            self.productListCollectionView.isHidden = false
            productCell.productNameLabel.text = filteredProducts[indexPath.row].title
            productCell.productImageView.kf.setImage(with:URL(string:filteredProducts[indexPath.row].image?.src ?? ""))
            productCell.productImageView.kf.indicatorType = .activity
            if  let variant = filteredProducts[indexPath.row].variants, let price = variant[0].price {
                productCell.productPriceLabel.text = "$"+price
            }
        return productCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width*0.44, height: self.view.frame.width*0.6)
    }
}
// MARK: CollectionView delegate
extension ProductListViewController:UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let product = filteredProducts[indexPath.row]
        let filteredproductDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
        filteredproductDetailsVC.product = product
        self.navigationController?.pushViewController(filteredproductDetailsVC, animated: true)
    }
    
}

//MARK: searchbar delegate
extension ProductListViewController:UISearchBarDelegate{
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            isFiltered = true
        }

        func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
            isFiltered = false
        }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredProducts = []
        if searchText == ""{
            filteredProducts = originalProducts
        }else{
            for product in originalProducts{
                guard let title = product.title else{return}
                if title.hasPrefix(searchText) || title.hasPrefix(searchText.uppercased()){
                    filteredProducts.append(product)
                    self.notFoundImage.isHidden = true
                    self.productListCollectionView.isHidden = false
                }else{
                    self.notFoundImage.isHidden = false
                    self.productListCollectionView.isHidden = true
                    self.updateUi()
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
    
    func goToLoginPage(){
        let loginVC = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
}
