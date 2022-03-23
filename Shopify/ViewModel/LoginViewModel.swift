//
//  LoginViewModel.swift
//  Shopify
//
//  Created by Nasr on 16/03/2022.
//

import Foundation

class LoginViewModel{
    let networking = Networking()
    
    func checkUserIsLogged(email: String, password: String, completion: @escaping (Customer?)-> Void){
        networking.getAllCustomers { customers, error in
            guard let customers = customers, error == nil else {return}
            
            let filetr = customers.customers.filter { selectedCustomer in
                return selectedCustomer.email == email && selectedCustomer.tags == password
            }
            
            if filetr.count != 0{
                Helper.shared.setUserStatus(userIsLogged: true)
                guard let customerID = filetr[0].id, let userFirstName = filetr[0].first_name, let userLastName = filetr[0].last_name, let userEmail = filetr[0].email  else {return}
                Helper.shared.setUserID(customerID: customerID)
                Helper.shared.setUserName(userName: "\(userFirstName) \(userLastName)")
                Helper.shared.setUserEmail(userEmail: userEmail)
                completion(filetr[0])
            }else{
                completion(nil)
            }
        }
    }
}

