//
//  CoreDataServices.swift
//  Shopify
//
//  Created by Nasr on 19/03/2022.
//

import Foundation
import CoreData
import UIKit

class CoreDataServices{
}

extension CoreDataServices{
    func saveProductToWishList(completion: @escaping (Bool)-> Void){
        do{
            try context.save()
            completion(true)
        }catch{
            print("Error in saveProductToWishList", error.localizedDescription)
            completion(false)
        }
    }
}

extension CoreDataServices{
    func getAllWishListProduct(completion: @escaping ([WishListModel]?, Error?)-> Void){
        do{
            let productWishList = try context.fetch(WishListModel.fetchRequest())
            print("fetching data.....")
            completion(productWishList, nil)
       }catch{
           completion(nil, error)
            print("Error in getAllWishListProduct function: ", error.localizedDescription)
        }
    }
}

extension CoreDataServices{
    func getWishListProductForSelectedCustomer(customerID: Int, completion: @escaping ([WishListModel]?, Error?)-> Void){
        do{
            let productWishList = try context.fetch(WishListModel.fetchRequest())
            var selectedWishList: [WishListModel] = []
            for selectedCustomer in productWishList{
                if selectedCustomer.customerID == customerID{
                    selectedWishList.append(selectedCustomer)
                }
            }
            completion(selectedWishList, nil)
       }catch{
           completion(nil, error)
            print("Error in getAllWishListProduct function: ", error.localizedDescription)
        }
    }
}

extension CoreDataServices{
    func deletedSelectedProductFromWishList(product: WishListModel, complition: @escaping (Bool) -> Void){
        context.delete(product)
        do{
            try context.save()
            complition(true)
        }catch{
            print("Error when delete product from wish list: ", error.localizedDescription)
            complition(false)
        }
    }
}
