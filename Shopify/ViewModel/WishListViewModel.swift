//
//  WishListViewModel.swift
//  Shopify
//
//  Created by Nasr on 20/03/2022.
//

import Foundation

class WishListViewModel{
    
    let coreDataServices = CoreDataServices()
  
    func getProductFromWishList(completion: @escaping ([WishListModel]?, Error?) -> Void){
        coreDataServices.getAllWishListProduct { products, error in
            guard let products = products, error == nil else {
                completion(nil, error)
                return
            }
            completion(products, nil)
        }
    }
}
