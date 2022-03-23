//
//  MyOrdersViewModel.swift
//  Shopify
//
//  Created by Omar Ahmed on 23/03/2022.
//

import Foundation

class MyOrdersViewModel{
    
    let network = Networking()
    
    var bindSuccessToView: (()->()) = {}
    
    var orders: [OrdersFromAPI]! {
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
        self.fetchAllOrders()
    }
    
    func fetchAllOrders(){
        network.getAllOrders { orderFromAPI, error in
            if let orderFromAPI = orderFromAPI {
                
            }
        }
        }
    }
    
    
    
    
    
    
    
    
    

