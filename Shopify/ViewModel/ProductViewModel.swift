//
//  ProductViewModel.swift
//  Shopify
//
//  Created by Islam Noureldin on 15/03/2022.
//

import Foundation
class ProductViewModel: NSObject{
    
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
    override init(){
        super.init()
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
    func getProductsfromAPI(collectioID:Int,complition:@escaping (Products?,Error?)->Void){
        network.getAllProductsInCategory(complition: complition, collectionID: collectioID)
        
    }
}

