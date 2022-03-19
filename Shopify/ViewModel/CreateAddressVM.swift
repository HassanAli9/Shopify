//
//  CreateAddressVM.swift
//  Shopify
//
//  Created by Hassan on 19/03/2022.
//

import Foundation

class CreateAddressVM
{
let network:Networking = Networking()
    func createAddress(custAddress:CustomerAddress)
    {
        network.postAddress(address: custAddress)
    }
}
