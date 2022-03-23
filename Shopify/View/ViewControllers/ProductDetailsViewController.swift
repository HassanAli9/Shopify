//
//  ProductDetailsViewController.swift
//  Shopify
//
//  Created by Islam Noureldin on 15/03/2022.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    let productDetailsViewModel = ProductDetailsViewModel()
    let orderViewModel = OrderViewModel()

    var product : Product?
    @IBOutlet weak var productDescription: UITextView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var imageControl: UIPageControl!
    @IBOutlet weak var addToCart: UIButton!
    @IBOutlet weak var productDetailsCollectionView: UICollectionView!
    @IBOutlet weak var favoriteBtn: UIButton!
        
    @IBAction func addToCartBtn(_ sender: Any) {
        
        orderViewModel.bindingAlreadyInCartToView = {
            self.showToast(message: "Already in Cart", font: .boldSystemFont(ofSize: 15))
        }
        orderViewModel.addItemsToCart(product: product!)
        
        UIView.animate(withDuration: 0.5, delay: 0,
                       usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1,
                       options: [], animations: {
                        self.addToCart.transform =
                           CGAffineTransform(scaleX: 2.0, y: 2.0)
                        self.addToCart.transform =
                           CGAffineTransform(scaleX: 1.0, y: 1.0)
                    }, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           self.checkProductInWishList()
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()

       setupImageCollection()
        setupImageCollection()
        updateUi()
    }
    
    private func setupImageCollection(){
        productDetailsCollectionView.dataSource = self
        productDetailsCollectionView.delegate = self
        productDetailsCollectionView.register(ProductDetailsImageCollectionCell.nib(), forCellWithReuseIdentifier: ProductDetailsImageCollectionCell.identifier)
    }
    
   

    private func updateUi(){
        guard let product = product ,let variant = product.variants, let price = variant[0].price else{return}
        productDescription.text = product.body_html
        productTitleLabel.text = product.title
        productPriceLabel.text = price + " USD"
    }
    
    func showToast(message : String, font: UIFont) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2-100, y: self.view.frame.size.height-200, width: 200, height: 40))
        toastLabel.backgroundColor = .label
        toastLabel.textColor = .systemBackground
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.layer.cornerRadius = 8;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 5.0, delay: 0.5, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    @IBAction func addToWishListBtn(_ sender: UIButton) {
        Helper.shared.checkUserIsLogged { userLogged in
            if userLogged{
                self.selectedFavoritBtn(sender: sender)
            }else{
                self.goToLoginPage()
            }
        }
    }
    
    @IBAction func moreProductsBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
}

extension ProductDetailsViewController: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let product = product,let images = product.images else{return 0}
        imageControl.numberOfPages = images.count
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let productDetailsCell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductDetailsImageCollectionCell.identifier, for: indexPath) as! ProductDetailsImageCollectionCell
        guard let product = product,let images = product.images else{return UICollectionViewCell()}
        productDetailsCell.productImageDetails.kf.setImage(with: URL(string: images[indexPath.row].src ?? "test"), placeholder: UIImage(named: "test"))
        return productDetailsCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        imageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}

extension ProductDetailsViewController{
    func selectedFavoritBtn(sender: UIButton){
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            //button selected
            print("selected")
            self.favoriteBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            addToWishList()
        }
        else{
            //button non selected
            print("non selected")
            self.favoriteBtn.setImage(UIImage(systemName: "heart"), for: .normal)
            nonSelectedProduct()
        }
    }
}
extension ProductDetailsViewController{
    func goToLoginPage(){
        let loginVC = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
}

extension ProductDetailsViewController{
    func addToWishList(){
        let productWishList = WishListModel(context: context)
        guard let product = product, let id = product.id, let variants = product.variants, let customerID = Helper.shared.getUserID() else {return}
        productWishList.customerID = Int64(customerID)
        productWishList.productID = Int64(id)
        productWishList.productName = product.title
        productWishList.productImage = product.image?.src
        productWishList.productPrice = variants[0].price
        
        productDetailsViewModel.saveProductToWishList()
    }
}

extension ProductDetailsViewController{
    func nonSelectedProduct(){
        guard let productId = product?.id else {return}
        productDetailsViewModel.deletedSelectedProduct(productID: productId)
    }
}

extension ProductDetailsViewController{
    func checkProductInWishList(){
        guard let productId = product?.id else {return}
        productDetailsViewModel.checkIfProductFoundInWishList(productID: productId) { productIsFoundInWishList in
            if productIsFoundInWishList{
                self.favoriteBtn.isSelected = true
                self.favoriteBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            }
        }
    }
}
