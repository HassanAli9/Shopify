//
//  CategoriesVC.swift
//  Shopify
//
//  Created by Omar Ahmed on 13/03/2022.
//

import UIKit
import Floaty

class CategoriesVC: UIViewController {
    
    
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    let floaty = Floaty()
    var ArrayOfProduct : [Product] = []
    var categoryViewModel = CategoriesViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        initTheCollectionView()
        
        categoriesCollectionView.register(UINib(nibName: "ProductInCategoryCVC", bundle: nil), forCellWithReuseIdentifier: "ProductInCatCell")
        
        // Float Action button animation style
        makeFloatyStyleButton()
        
        categoryViewModel.bindingCategoriesViewModelToView = {
            self.onSuccess()
        }
        
        categoryViewModel.bindingErrorToView = {
            self.onFailed()
        }
        
    }
    
    func onSuccess(){
        self.ArrayOfProduct=categoryViewModel.allProducts
        self.categoriesCollectionView.reloadData()
    }
    
    func onFailed(){
        let alert = UIAlertController(title: "Error", message: categoryViewModel.errorMessage, preferredStyle: .alert)
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
        floaty.buttonImage = UIImage(systemName: "rectangle.3.group.fill")
        floaty.addItem("T-Shirts", icon: UIImage(systemName: "tshirt.fill"))
        floaty.addItem("Shoes", icon: UIImage(systemName: "circle.hexagonpath.fill"))
        floaty.addItem("Accessoreies", icon: UIImage(systemName: "circle.hexagonpath.fill"))
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
        cell.productPriceCat.text =  "$199"
        
        return cell
    }
    
}
