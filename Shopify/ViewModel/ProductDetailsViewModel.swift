//
//  ProductDetailsViewModel.swift
//  Shopify
//
//  Created by Nasr on 20/03/2022.
//

import Foundation

class ProductDetailsViewModel{
    let coreDataServices = CoreDataServices()

    func saveProductToWishList(){
        coreDataServices.saveProductToWishList { saveSuccess in
            if saveSuccess{
                print("success to save product in wishlist")
            }else{
                print("failed to save product in wishlist")
            }
        }
    }
}
