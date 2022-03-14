//
//  CategoriesViewModel.swift
//  Shopify
//
//  Created by Omar Ahmed on 14/03/2022.
//

import Foundation


class CategoriesViewModel : NSObject {
    
    let networkService = Networking()
    var bindingCategoriesViewModelToView : (()->()) = {}
    var bindingErrorToView : (()->()) = {}
    
    var allProducts:[Product]{
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

    }
    
    
    
   
    
    
}
