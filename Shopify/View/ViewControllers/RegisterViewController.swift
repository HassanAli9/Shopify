//
//  RegisterViewController.swift
//  Shopify
//
//  Created by Nasr on 15/03/2022.
//
import UIKit
import TextFieldEffects
import NVActivityIndicatorView

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: AkiraTextField!
    @IBOutlet weak var lastNameTextField: AkiraTextField!
    @IBOutlet weak var emailTextField: AkiraTextField!
    @IBOutlet weak var passwordTextField: AkiraTextField!
    @IBOutlet weak var confirmPasswordTextField: AkiraTextField!
    
    var registerViewModel = RegisterViewModel()
    var indicator = NVActivityIndicatorView(frame: .zero, type: .ballBeat, color: .blue , padding: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signUpDidPressed(_ sender: Any) {
        checkBeforeRegister()
    }
    
    @IBAction func moveToLoginPageDidPressed(_ sender: Any) {
    }
}

extension RegisterViewController{
    func checkInfoBeforeRegister()->Bool{
        self.showActivityIndicator(indicator: self.indicator, startIndicator: true)
        
        var checkIsSuccess = true
        guard let firstName = firstNameTextField.text, let lastName = lastNameTextField.text, let email = emailTextField.text,
                let password = passwordTextField.text, let confirmPassword = confirmPasswordTextField.text else {return false}
      
        
        registerViewModel.checkCustomerInfo(firstName: firstName, lastName: lastName, email: email, password: password, confirmPassword: confirmPassword) { message in
            
            switch message {
            case "ErrorAllInfoIsNotFound":
                checkIsSuccess = false
                self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
                self.showAlertErrro(title: "your information not found", message: "please fill yout infromation to reister")
            case "ErrorUserInfo":
                checkIsSuccess = false
                self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
                self.showAlertErrro(title: "user name is incorrect", message: "please enter correct name")
            case "ErrorPassword":
                checkIsSuccess = false
                self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
                self.showAlertErrro(title: "There is a problem with the password", message: "please enter password again")
            case "ErrorEmail":
                checkIsSuccess = false
                self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
                self.showAlertErrro(title: "your email is incorrect", message: "please enter correct email")
            case "ErrorEmailIsExist":
                checkIsSuccess = false
                self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
                self.showAlertErrro(title: "your email is already exist", message: "can you login!!")
            default:
                checkIsSuccess = true
            }
        }
        return checkIsSuccess
    }
}

extension RegisterViewController{
    func register(){
        
        DispatchQueue.main.async {
            self.showActivityIndicator(indicator: self.indicator, startIndicator: true)
        }
        
        guard let firstName = firstNameTextField.text, let lastName = lastNameTextField.text, let email = emailTextField.text,
              let password = passwordTextField.text else {return}
        
        let customer = Customer(first_name: firstName, last_name: lastName, email: email, phone: nil, tags: password, id: nil, verified_email: true, addresses: nil)
        let newCustomer = NewCustomer(customer: customer)
        
        registerViewModel.createNewCustomer(newCustomer: newCustomer) { data, response, error in
            
            guard error == nil else {
                //register is not success
                DispatchQueue.main.async {
                    self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
                }
                return
            }
            //register is success
            DispatchQueue.main.async {
                self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
            }
            print("register is success")
        }
    }
}

extension RegisterViewController{
    func checkBeforeRegister(){
        if checkInfoBeforeRegister(){
            register()
        }
    }
}


