//
//  CategoriesViewModel.swift
//  Shopify
//
//  Created by Omar Ahmed on 14/03/2022.
//

import Foundation


class CategoriesViewModel : NSObject {
    
    var networkService = Networking()
    var bindingCategoriesViewModelToView : (()->()) = {}
    var bindingErrorToView : (()->()) = {}
    
    var allProducts:[Product]!{
        didSet {
            self.bindingCategoriesViewModelToView()
        }
    }

    var errorMessage:String!{
        didSet{
            self.bindingErrorToView()
        }
    }

    override init() {
        super.init()
        self.networkService = Networking()
        self.fetchProductsfromAPI()

    }
    
    func fetchProductsfromAPI(){
        networkService.getAllProductsInCategory { products, error in
            if let productsList = products {
                self.allProducts=productsList.products!
            }else{
                let msg = error?.localizedDescription
                self.errorMessage  = msg
            }
        }
    }
    
    
    
   
    
    
}
