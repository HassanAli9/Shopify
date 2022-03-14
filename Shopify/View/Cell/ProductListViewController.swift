//
//  ProductListViewController.swift
//  Shopify
//
//  Created by Islam Noureldin on 14/03/2022.
//

import UIKit

class ProductListViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var productListCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        setupProductCollection()
   
    }
    
    private func setupProductCollection(){
        self.productListCollectionView.delegate = self
        self.productListCollectionView.dataSource = self
        self.productListCollectionView.register(ProductListCell.nib(), forCellWithReuseIdentifier: ProductListCell.identifier)
    }


}

extension ProductListViewController{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let productCell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductListCell.identifier, for: indexPath)
        
        return productCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width*0.4, height: self.view.frame.width*0.7)
    }

    
}
