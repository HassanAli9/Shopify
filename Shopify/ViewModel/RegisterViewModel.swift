//
//  RegisterViewModel.swift
//  Shopify
//
//  Created by Nasr on 16/03/2022.
//
import Foundation

class RegisterViewModel{
    
    let networkServices = Networking()
    static var emailIsExist = true
    
    func checkCustomerInfo(firstName: String, lastName: String, email: String, password: String, confirmPassword: String, compeltion: @escaping (String?) ->Void){
        
       
        
        guard !firstName.isEmpty, !lastName.isEmpty, !email.isEmpty, !password.isEmpty, !confirmPassword.isEmpty else {
            compeltion("ErrorAllInfoIsNotFound")
            return
        }
        
        guard emailIsValid(email) else {
            compeltion("ErrorEmail")
            return
        }
        
        guard passwordIsValied(password: password, confirmPassword: confirmPassword) else {
            compeltion("ErrorPassword")
            return
        }
        
        guard userInfoIsValied(firstName: firstName, lastName: lastName) else {
            compeltion("ErrorUserInfo")
            return
        }
        
        
        guard !checkUserIsExist(email: email) else {
            compeltion("ErrorEmailIsExist")
            return
        }
    }
    
    func createNewCustomer(newCustomer: NewCustomer, completion:@escaping (Data?, URLResponse? , Error?)->()){
        networkServices.register(newCustomer: newCustomer) { data, response, error in
            if error == nil {
                completion(data, response, nil)
            }else{
                completion(nil, nil, error)
            }
        }
    }
    
    func emailIsValid(_ email: String) -> Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if emailPred.evaluate(with: email){
            return true
        }else{
            return false
        }
    }
    
    func passwordIsValied(password: String, confirmPassword: String) -> Bool{
        if !password.isEmpty && password.count >= 6 && !confirmPassword.isEmpty && confirmPassword.count >= 6 && password == confirmPassword{
            return true
        }else {
            return false
        }
    }
    
    func userInfoIsValied(firstName: String, lastName: String) -> Bool{
        if !firstName.isEmpty && !lastName.isEmpty {
            return true
        }else{
            return false
        }
    }
    
    func checkUserIsExist(email: String) -> Bool{
       
        networkServices.getAllCustomers { customers, error in
            guard let customers = customers, error == nil else {return}
            
            let filetr = customers.customers.filter { selectedCustomer in
                return selectedCustomer.email == email
            }
            print(filetr.count)
            if filetr.count != 0{
                RegisterViewModel.emailIsExist = true
            }else{
                RegisterViewModel.emailIsExist = false
            }
        }
        
        print(RegisterViewModel.emailIsExist)
        return RegisterViewModel.emailIsExist
    }
}
