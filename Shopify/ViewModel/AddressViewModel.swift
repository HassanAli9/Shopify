//
//  AddressViewModel.swift
//  Shopify
//
//  Created by Nasr on 24/03/2022.
//

import Foundation

class AddressViewModel{
    
    let networking = Networking()
    
    var bindSuccessToView: (()->()) = {}
    var address: [Address]! {
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
        self.getAllAddressForCustomer()
    }
    
    func getAllAddressForCustomer(){
        networking.getAllAddresses { arrOfAdderess, error in
            guard let arrOfAdderess = arrOfAdderess, error == nil else {
                self.error = error
                return
            }
            self.address = arrOfAdderess
        }
    }
}
