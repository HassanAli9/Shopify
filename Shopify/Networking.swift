//
//  Networking.swift
//  Shopify
//
//  Created by Nasr on 14/03/2022.
//

import Foundation
import Alamofire
import SwiftUI

class Networking{
    
    static var shared = Networking()
}

extension Networking{
    
    func getAllBrands(complition: @escaping (BrandsModel?, Error?)->Void){
        
        guard let url = URLs.shared.getAllBrandsURl() else {return}
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).response { res in
            switch res.result{
            case .failure(let error):
                print("error")
                complition(nil, error)
            case .success(_):
                guard let data = res.data else { return }
                do{
                    let json = try JSONDecoder().decode(BrandsModel.self, from: data)
                    complition(json, nil)
                    print("success to get all brands")
                }catch let error{
                    print("error when get All brands")
                    complition(nil, error)
                }
            }
        }
    }
    
    
    func getAllProductsInCategory(complition: @escaping (Products?,Error?)->Void){
        
        guard let url = URLs.shared.getAllProductsInCategories() else {return}
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).response {
            result in
            switch result.result {
            case .failure(let error):
                complition(nil,error)
            case .success(_):
                guard let data = result.data else {return}
                do{
                    let json = try JSONDecoder().decode(Products.self, from: data)
                    complition(json, nil)
                    print("Success")
                    
                }catch let error{
                    complition(nil, error)
                }
            }
        }
    }
}

extension Networking{
    func register(newCustomer:NewCustomer, completion:@escaping (Data?, URLResponse? , Error?)->()){
        guard let url = URLs.shared.customersURl() else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let session = URLSession.shared
        request.httpShouldHandleCookies = false
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: newCustomer.asDictionary(), options: .prettyPrinted)
            print(try! newCustomer.asDictionary())
        } catch let error {
            print(error.localizedDescription)
        }
        
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        session.dataTask(with: request) { (data, response, error) in
            completion(data, response, error)
        }.resume()
    }
}

extension Networking{
    func getAllCustomers(complition: @escaping (Customers?, Error?)->Void){
        guard let url = URLs.shared.customersURl() else {return}
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).response { res in
            switch res.result{
            case .failure(let error):
                print("error")
                complition(nil, error)
            case .success(_):
                guard let data = res.data else { return }
                do{
                    let json = try JSONDecoder().decode(Customers.self, from: data)
                    complition(json, nil)
                    print("success to get customers")
                }catch let error{
                    print("error when get customers")
                    complition(nil, error)
                }
            }
        }
    }
    
    
}
