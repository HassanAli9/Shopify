//
//  CategoriesVC.swift
//  Shopify
//
//  Created by Omar Ahmed on 13/03/2022.
//

import UIKit
import Floaty

class CategoriesVC: UIViewController {
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    
    
    let floaty = Floaty()
    var ArrayOfProduct : [Product] = []
    var categoryViewModel = CategoriesViewModel()
    var collectionID : Int = 272069034031
    var isFiltered = false
    var FilterdArr:[Product]=[]

    override func viewDidLoad() {
        super.viewDidLoad()
        initTheCollectionView()
        
        categoriesCollectionView.register(UINib(nibName: "ProductInCategoryCVC", bundle: nil), forCellWithReuseIdentifier: "ProductInCatCell")
        
        // Float Action button animation style
        makeFloatyStyleButton()
        spinner.hidesWhenStopped=true
        spinner.startAnimating()
        categorizedTheProducts(cID: collectionID)
        spinner.stopAnimating()
        
    }
    
    @IBAction func segDidChange(_ sender: Any) {
        print("index = \(segmentedControl.selectedSegmentIndex)")
        self.FilterdArr=[]
        isFiltered=false
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            collectionID = 272069034031
            categorizedTheProducts(cID: collectionID)
        case 1:
            collectionID  = 272069066799
            categorizedTheProducts(cID: collectionID)
        case 2:
            collectionID=272069099567
            categorizedTheProducts(cID: collectionID)

        default:
            collectionID  = 272069132335
            categorizedTheProducts(cID: collectionID)
        }
        
    }
    
    func categorizedTheProducts(cID:Int){
        categoryViewModel.getProductsfromAPI(collectioID: cID, complition: { products, error in
            if let productsList = products {
                self.ArrayOfProduct=productsList.products!
                self.categoriesCollectionView.reloadData()
            }else{
               self.onFailed(error: error!)
               print("error")
            }
        })
        
    }
    
    func onFailed(error:Error){
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func initTheCollectionView(){
        categoriesCollectionView.delegate=self
        categoriesCollectionView.dataSource=self
    }
    
    func makeFloatyStyleButton(){
        floaty.buttonColor =  .label
        floaty.paddingX = 40
        floaty.paddingY = 100
        floaty.openAnimationType = .slideLeft
        floaty.buttonImage = UIImage(named: "sort")
        floaty.itemButtonColor = .label
        floaty.itemTitleColor = .label
        floaty.addItem("T-Shirts", icon: UIImage(named: "shirt")) { item in
            let filered = self.ArrayOfProduct.filter { item in
                return item.product_type=="T-SHIRTS"
            }
            self.FilterdArr=filered
            self.isFiltered=true
            self.categoriesCollectionView.reloadData()
        }
        floaty.addItem("Shoes", icon: UIImage(named: "shoes")){ item in
            let filered = self.ArrayOfProduct.filter { item in
                return item.product_type=="SHOES"
            }
            self.FilterdArr=filered
            self.isFiltered=true
            self.categoriesCollectionView.reloadData()
        }
        floaty.addItem("Accessories", icon: UIImage(named: "acc")){ item in
            let filered = self.ArrayOfProduct.filter { item in
                return item.product_type=="ACCESSORIES"
            }
            self.FilterdArr=filered
            self.isFiltered=true
            self.categoriesCollectionView.reloadData()
        }
        view.addSubview(floaty)
    }
    
    @IBAction func toSearch(_ sender: Any) {
    }
    
    @IBAction func toCart(_ sender: Any) {
    }
    
    @IBAction func toWishlist(_ sender: Any) {
    }
    
}



extension CategoriesVC :  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width*0.44, height: self.view.frame.width*0.6)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(isFiltered){
            return FilterdArr.count
        }else{
            return ArrayOfProduct.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductInCatCell", for: indexPath) as! ProductInCategoryCVC
        
        cell.productImgViewCat.layer.cornerRadius=20
        cell.favView.layer.shadowRadius=2
        cell.favView.layer.shadowOpacity=0.5
        
        if(isFiltered){
            cell.productImgViewCat.kf.indicatorType = .activity
            if let prodImage = FilterdArr[indexPath.row].image?.src {
                cell.productImgViewCat.kf.setImage(with: URL(string: prodImage))
            }
            cell.productNameCat.text = FilterdArr[indexPath.row].title
            cell.productPriceCat.text =  "$\(FilterdArr[indexPath.row].variants?[0].price ?? "0")"
            
        }else{
            cell.productImgViewCat.kf.indicatorType = .activity
            if let prodImage = ArrayOfProduct[indexPath.row].image?.src {
                cell.productImgViewCat.kf.setImage(with: URL(string: prodImage))
            }
            cell.productNameCat.text = ArrayOfProduct[indexPath.row].title
            cell.productPriceCat.text =  "$\(ArrayOfProduct[indexPath.row].variants?[0].price ?? "0")"
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected")
    }
    
}
