//
//  OrderViewModel.swift
//  Shopify
//
//  Created by Omar Ahmed on 20/03/2022.
//

import Foundation
import CoreMedia


class OrderViewModel{
    
    var bindingAlreadyInCartToView : (()->()) = {}
    var bindingDeleteCartToView : (()->()) = {}
    var order : OrderItem?
    let customerID = Helper.shared.getUserID()
    
    
    var showAlreadyExist : (()->()) {
        self.bindingAlreadyInCartToView
    }
    var showDeleteAlert : (()->()) {
        self.bindingDeleteCartToView
    }
    
    func getItemsInCart(complition: @escaping (([OrderItemModel]?,Error?)->Void)){
        
        do {
            let cartItems = try context.fetch(OrderItemModel.fetchRequest())
            complition(cartItems, nil)
            
        } catch let error {
            complition(nil, error)
        }
        
    }
   
    
    
    
    func addItemsToCart(product:Product){
        do {
            let items = try context.fetch(OrderItemModel.fetchRequest())
            if checkIfItemExist(itemId: product.id!,itemms: items){
                print("Already in cart")
                self.showAlreadyExist()
            }else{
                let orderItem = OrderItemModel(context: context)
                 orderItem.itemID = Int64(product.id!)
                 orderItem.itemName = product.title
                 orderItem.itemPrice = product.variants![0].price
                 orderItem.itemImage = product.image?.src
                 orderItem.itemQuantity = 1
                 orderItem.userID = Int64(customerID!)
                 try? context.save()
                 print(orderItem)
            }
        } catch let error {
            print(error)
        }

       
       
       
    
    }
    
    func checkIfItemExist(itemId: Int,itemms:[OrderItemModel]) -> Bool {
        var check : Bool = false
            for i in itemms {
                if i.itemID == itemId {
                   check = true
                }else {
                    check = false
                }
            }
        return check
        }
    
    func deleteFromCoreData(indexPath:IndexPath,cartItems:[OrderItemModel]){
        context.delete(cartItems[indexPath.row])
        try? context.save()
    }
    
    
}
