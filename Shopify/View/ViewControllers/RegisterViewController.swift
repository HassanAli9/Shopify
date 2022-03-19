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
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func signUpDidPressed(_ sender: Any) {
        checkBeforeRegister()
    }
    
    @IBAction func moveToLoginPageDidPressed(_ sender: Any) {
        goToLoginPage()
    }
    
    func goToLoginPage(){
        let loginVc = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        
        self.navigationController?.pushViewController(loginVc, animated: true)
    }
}

extension RegisterViewController{
    func checkInfoBeforeRegister()->Bool{
        DispatchQueue.main.async {
            self.showActivityIndicator(indicator: self.indicator, startIndicator: true)
        }
        
        var checkIsSuccess = true
        guard let firstName = firstNameTextField.text, let lastName = lastNameTextField.text, let email = emailTextField.text,
              let password = passwordTextField.text, let confirmPassword = confirmPasswordTextField.text else {return false}
        
        
        self.registerViewModel.checkCustomerInfo(firstName: firstName, lastName: lastName, email: email, password: password, confirmPassword: confirmPassword) { message in
            
            switch message {
            case "ErrorAllInfoIsNotFound":
                checkIsSuccess = false
                DispatchQueue.main.async {
                    self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
                }
                self.showAlertErrro(title: "please fill your infromation to reister", message: "for register must fill all information")
            case "ErrorPassword":
                checkIsSuccess = false
                DispatchQueue.main.async {
                    self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
                }
                self.showAlertErrro(title: "There is a problem with the password", message: "please enter password again")
            case "ErrorEmail":
                checkIsSuccess = false
                DispatchQueue.main.async {
                    self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
                }
                self.showAlertErrro(title: "your email is incorrect", message: "please enter correct email")
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
        
        registerViewModel.checkUserIsExist(email: email) { emailIsExist in
            if !emailIsExist{
                self.registerViewModel.createNewCustomer(newCustomer: newCustomer) { data, response, error in
                    
                    guard error == nil else {
                        //register is not success
                        DispatchQueue.main.async {
                            self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
                        }
                        return
                    }
                    Helper.shared.setUserStatus(userIsLogged: true)
                    //register is success
                    DispatchQueue.main.async {
                        self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
                        UIApplication.shared.keyWindow?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarViewController")
                    }
                    
                    print("register is success")
                    
                }
            }else{
                DispatchQueue.main.async {
                    self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
                }
                self.showAlertErrro(title: "your email is already exist", message: "can you login!!")
            }
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


