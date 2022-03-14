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

    override func viewDidLoad() {
        super.viewDidLoad()
        categoriesCollectionView.delegate=self
        categoriesCollectionView.dataSource=self
        
        categoriesCollectionView.register(UINib(nibName: "ProductInCategoryCVC", bundle: nil), forCellWithReuseIdentifier: "ProductInCatCell")
        
        // Float Action button animation style
        floaty.buttonColor =  .label
        floaty.paddingX = 40
        floaty.paddingY = 100
        floaty.openAnimationType = .slideLeft
        floaty.buttonImage = UIImage(systemName: "rectangle.3.group.fill")
        floaty.addItem("T-Shirts", icon: UIImage(systemName: "tshirt.fill"))
        floaty.addItem("Shoes", icon: UIImage(systemName: "circle.hexagonpath.fill"))
        floaty.addItem("Trousers", icon: UIImage(systemName: "circle.hexagonpath.fill"))
        view.addSubview(floaty)
    }
    

}


extension CategoriesVC :  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width*0.44, height: self.view.frame.width*0.7)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 17
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductInCatCell", for: indexPath) as! ProductInCategoryCVC
        
        cell.productImgViewCat.image = UIImage(named: "33")
        cell.productNameCat.text = "Black Sweet T-Shirt"
        cell.productPriceCat.text =  "$199"
        
        return cell
    }
    
}
