//
//  RegisterViewController.swift
//  Shopify
//
//  Created by Nasr on 15/03/2022.
//

import UIKit
import TextFieldEffects

class RegisterViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: AkiraTextField!
    
    
    @IBOutlet weak var lastNameTextField: AkiraTextField!
    
    @IBOutlet weak var emailTextField: AkiraTextField!
    
    @IBOutlet weak var passwordTextField: AkiraTextField!
    
    
    @IBOutlet weak var confirmPasswordTextField: AkiraTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpDidPressed(_ sender: Any) {
        print("register")
        //let customer = Customer(id: nil, email: "ahmed.nasr.saieed@gmail.com", firstName: "Ahmed", lastName: "Nasr", verifiedEmail: true, phone: "01028384252", tags: nil, address: nil)
        //let newCustomer = NewCustomer(customer: customer)
        
        /*let customer = Customer(first_name: "rdwan", last_name: "mo", email: "rdwan@gmail.com", phone: nil, tags: "89778", id: nil, verified_email: true, addresses: nil)
        let newCustomer = NewCustomer(customer: customer)
        Networking.shared.registerCustomer(newCustomer: newCustomer) { data, res, error in
            if error == nil {
                print("register is success")
            }else {
                print("resiet is fira")
            }
        }*/

    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    @IBAction func moveToLoginPageDidPressed(_ sender: Any) {
    }
}


