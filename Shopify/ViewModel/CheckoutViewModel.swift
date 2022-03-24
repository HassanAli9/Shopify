//
//  CheckoutViewModel.swift
//  Shopify
//
//  Created by Nasr on 24/03/2022.
//

import Foundation

class CheckoutViewModel{
    
    let coreDataServices = CoreDataServices()
    
    
    func getSelectedAddress(completion: @escaping (AddressModel?, Error?)-> Void){
        coreDataServices.getAddress { selectedAddress, error in
            if let selectedAddress = selectedAddress {
                completion(selectedAddress, nil)
            }else{
                completion(nil, error)
            }
        }
    }
}
