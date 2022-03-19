//
//  user.swift
//  Shopify
//
//  Created by Nasr on 16/03/2022.
//

import Foundation

struct NewCustomer: Codable {
    let customer: Customer
}

struct Customers: Codable {
    let customers: [Customer]
}

struct Customer: Codable {
    let first_name, last_name, email, phone, tags: String?
    let id: Int?
    let verified_email: Bool?
    let addresses: [Address]?
}

struct Address: Codable {
    var address1, city, province, phone: String?
    var zip, last_name, first_name, country: String?
    var id: Int!
    
    
    init(address:String , city:String, phone:String, country:String) {
        self.address1 = address
        self.city     = city
        self.phone    = phone
        self.country  = country
    }
}

struct LoginResponse: Codable {
    let customers: [Customer]
}

struct CustomerAddress: Codable {
    var addresses: [Address]?
}

struct UpdateAddress: Codable {
    var address: Address
}

struct PutAddress: Codable {
    let customer: CustomerAddress?
}
