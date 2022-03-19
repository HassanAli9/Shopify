//
//  Networking+Address.swift
//  Shopify
//
//  Created by Hassan on 19/03/2022.
//

import Foundation

extension Networking
{
    func postAddress(address:CustomerAddress)
    {
        
         let url = URLs.shared.addressURL(customerId: "207119551")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        let session = URLSession.shared
        request.httpShouldHandleCookies = false
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: address.asDictionary(), options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        session.dataTask(with: request) { (data, response, error) in
        }.resume()
    }
    
}
