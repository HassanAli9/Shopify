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
