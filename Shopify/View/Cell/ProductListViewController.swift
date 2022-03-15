//
//  ProductListViewController.swift
//  Shopify
//
//  Created by Islam Noureldin on 14/03/2022.
//

import UIKit
import Kingfisher

class ProductListViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{

    var products = [Product]()
    
    @IBOutlet weak var productListCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        setupProductCollection()
        Networking.shared.getAllProducts { data, error in
            guard let data = data else {
                return
            }
            self.products = data
            print(self.products.first?.title)
            self.updateUi()
        }
        
    }
    
    private func setupProductCollection(){
        self.productListCollectionView.delegate = self
        self.productListCollectionView.dataSource = self
        self.productListCollectionView.register(ProductListCell.nib(), forCellWithReuseIdentifier: ProductListCell.identifier)
    }
    private func updateUi(){
        DispatchQueue.main.async {
        self.productListCollectionView.reloadData()
        }
    }

}

extension ProductListViewController{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let productCell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductListCell.identifier, for: indexPath) as! ProductListCell
        productCell.productNameLabel.text = products[indexPath.row].title
        productCell.productImageView.kf.setImage(with: URL(string: products[indexPath.row].image?.src ?? ""))
    
        if  let variant = products[indexPath.row].variants, let price = variant[0].price {
            productCell.productPriceLabel.text = price
        }
        
        return productCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width*0.44, height: self.view.frame.width*0.6)
    }

    
}
