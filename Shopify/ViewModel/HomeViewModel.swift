//
//  HomeViewModel.swift
//  Shopify
//
//  Created by Nasr on 14/03/2022.
//
import Foundation

class HomeViewModel{
    
    let network = Networking()
    
    var bindSuccessToView: (()->()) = {}
    var brands: [Smart_collections]! {
        didSet{
            self.bindSuccessToView()
        }
    }
    
    var bindFailedToView: (()->()) = {}
    var error: Error!{
        didSet{
            self.bindFailedToView()
        }
    }
    
    init(){
        self.fetchAllBrands()
    }
    
    func fetchAllBrands(){
        network.getAllBrands { brands, error in
            if let brands = brands, let smartBrnds = brands.smart_collections{
                self.brands = smartBrnds
            }else{
                self.error = error
            }
        }
    }
}

