//
//  CategoriesVC.swift
//  Shopify
//
//  Created by Omar Ahmed on 13/03/2022.
//

import UIKit
import Floaty

class CategoriesVC: UIViewController {
    
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    let floaty = Floaty()
    var ArrayOfProduct : [Product] = []
    var categoryViewModel = CategoriesViewModel()
    var collectionID : Int = 272069034031

    override func viewDidLoad() {
        super.viewDidLoad()
        initTheCollectionView()
        
        categoriesCollectionView.register(UINib(nibName: "ProductInCategoryCVC", bundle: nil), forCellWithReuseIdentifier: "ProductInCatCell")
        
        // Float Action button animation style
        makeFloatyStyleButton()
        
        categorizedTheProducts(cID: collectionID)
        
        
    }
    
    @IBAction func segDidChange(_ sender: Any) {
        print("index = \(segmentedControl.selectedSegmentIndex)")
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
        floaty.addItem("T-Shirts", icon: UIImage(named: "shirt"))
        floaty.addItem("Shoes", icon: UIImage(named: "shoes"))
        floaty.addItem("Accessories", icon: UIImage(named: "acc"))
        view.addSubview(floaty)
    }
    

}



extension CategoriesVC :  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width*0.44, height: self.view.frame.width*0.6)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ArrayOfProduct.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductInCatCell", for: indexPath) as! ProductInCategoryCVC
        
        cell.productImgViewCat.kf.indicatorType = .activity
        if let prodImage = ArrayOfProduct[indexPath.row].image?.src {
            cell.productImgViewCat.kf.setImage(with: URL(string: prodImage))
        }
        cell.productNameCat.text = ArrayOfProduct[indexPath.row].title
        cell.productPriceCat.text =  "$\(ArrayOfProduct[indexPath.row].variants?[0].price ?? "0")"
        
        return cell
    }
    
}
