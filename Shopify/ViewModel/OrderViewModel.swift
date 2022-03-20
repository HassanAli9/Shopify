//
//  OrderViewModel.swift
//  Shopify
//
//  Created by Omar Ahmed on 20/03/2022.
//

import Foundation
import CoreMedia


class OrderViewModel{
    
//    var bindingOrderItemToOrderView : (()->()) = {}
    var order : OrderItem?
    let customerID = Helper.shared.getUserID()
    
//    var allItems : [OrderItemModel] = [] {
//        didSet {
//            self.bindingOrderItemToOrderView
//        }
//    }
    
    func getItemsInCart(complition: @escaping (([OrderItemModel]?,Error?)->Void)){
        
        do {
            let cartItems = try context.fetch(OrderItemModel.fetchRequest())
            complition(cartItems, nil)
            
        } catch let error {
            complition(nil, error)
        }
        
    }
   
    
    
    
    func addItemsToCart(product:Product){
        print("ksdnfksdhfkjsdhf")
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
    
}
