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
    var bindeLinesitemToView : (()->()) = {}
    var bindFailedToView : (()->()) = {}
    
    var orders: [Order]! {
        didSet{
            self.bindSuccessToView()
        }
    }
    
    
    var showError: String!{
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
                self.orders = orderFromAPI
            }
            else{
                self.showError = error?.localizedDescription
            }
        }
        }
    }
    
    
    
    
    
    
    
    
    

