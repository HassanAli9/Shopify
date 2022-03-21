//
//  WishListViewModel.swift
//  Shopify
//
//  Created by Nasr on 20/03/2022.
//

import Foundation

class WishListViewModel{
    
    let coreDataServices = CoreDataServices()

    func getSelectedProducts(completion: @escaping ([WishListModel]?, Error?) -> Void){
        guard let customerID = Helper.shared.getUserID() else {return}
        coreDataServices.getWishListProductForSelectedCustomer(customerID: customerID) { products, error in
            guard let products = products, error == nil else {
                completion(nil, error)
                return
            }
            completion(products, nil)
        }
    }
    
    func deletedProduct(product: WishListModel, complection: @escaping (Bool)-> Void){
        coreDataServices.deletedSelectedProductFromWishList(product: product) { successDeleted in
            if successDeleted {
                complection(true)
            }else{
                complection(false)
            }
        }
    }
}

