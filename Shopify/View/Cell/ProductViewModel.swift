//
//  ProductViewModel.swift
//  Shopify
//
//  Created by Islam Noureldin on 15/03/2022.
//

import Foundation
class ProductViewModel{
    
    var network = Networking()
    var bindSuccessToView : (()->()) = {}
    var products : [Product]! {
        didSet {
            self.bindSuccessToView()
        }
    }
    var bindFailedToView : (()->()) = {}
    var error : Error!{
        didSet{
            self.bindFailedToView()
        }
    }
    var selectedProduct : Product?
    init(){
        self.fetchProductDataFromNetwork()
    }
    
    func fetchProductDataFromNetwork(){
        network.getAllProducts { products, error in
            if let products = products{
                self.products = products
            }else{
                self.error = error
            }
        }
    }
}
extension ProductViewModel{
    func userPressed(at indexPath : IndexPath){
        let product = self.products[indexPath.row]
        self.selectedProduct = product
    }
}
