//
//  OrderViewModel.swift
//  Shopify
//
//  Created by Omar Ahmed on 20/03/2022.
//

import Foundation
import CoreMedia

class OrderViewModel{
    
    let coreDataServices = CoreDataServices()
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

extension OrderViewModel{
    func getSelectedItemInCart(productId: Int64, completion: @escaping (OrderItemModel?, Error?)-> Void){
        getItemsInCart { orders, error in
            if error == nil {
                guard let orders = orders, let customerID = self.customerID else { return }
                for item in orders {
                    if item.itemID == productId && item.userID == customerID {
                        completion(item, nil)
                    }
                }
            }else{
                completion(nil, error)
            }
        }
    }
}

extension OrderViewModel{
    func getSelectedProducts(completion: @escaping ([OrderItemModel]?, Error?) -> Void){
        guard let customerID = Helper.shared.getUserID() else {return}
        coreDataServices.getCartProductForSelectedCustomer(customerID: customerID) { orders, error in
            guard let orders = orders, error == nil else {
                completion(nil, error)
                return
            }
            completion(orders, nil)
        }
    }
}

extension OrderViewModel{
    func saveProductToCart(){
        coreDataServices.saveProductToWishList { saveSuccess in
            if saveSuccess{
                print("success to save product in cart")
            }else{
                print("failed to save product in cart")
            }
        }
    }
}

extension OrderViewModel{
    func calcTotalPrice(completion: @escaping (Double?)-> Void){
        var totalPrice: Double = 0.0
        getItemsInCart { orders, error in
            if error == nil {
                guard let orders = orders, let customerID = self.customerID  else { return }
                for item in orders{
                    if item.userID == customerID {
                        guard let priceStr = item.itemPrice, let price = Double(priceStr) else { return }
                        totalPrice += Double(item.itemQuantity) * price
                    }
                }
                completion(totalPrice)
            }else{
                completion(nil)
            }
        }
    }
}
