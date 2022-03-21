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
    @IBOutlet weak var loginLabel: UILabel!
    
    var registerViewModel = RegisterViewModel()
    var indicator = NVActivityIndicatorView(frame: .zero, type: .ballClipRotateMultiple, color: .label , padding: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
        self.hideKeyboardWhenTappedAround()
        setGestureOnLoginLabel()
        setupViewWhenShowKeyboard()
    }
    
    @IBAction func signUpDidPressed(_ sender: Any) {
        checkBeforeRegister()
    }
    
    func setupTextField(){
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
    }
    
    func setGestureOnLoginLabel(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(goToLoginPage))
        loginLabel.isUserInteractionEnabled = true
        loginLabel.addGestureRecognizer(tapGesture)
    }
    
   @objc func goToLoginPage(){
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
                self.showAlertError(title: "please fill your infromation to reister", message: "for register must fill all information")
            case "ErrorPassword":
                checkIsSuccess = false
                DispatchQueue.main.async {
                    self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
                }
                self.showAlertError(title: "There is a problem with the password", message: "please enter password again")
            case "ErrorEmail":
                checkIsSuccess = false
                DispatchQueue.main.async {
                    self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
                }
                self.showAlertError(title: "your email is incorrect", message: "please enter correct email")
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
                self.showAlertError(title: "your email is already exist", message: "can you login!!")
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

extension RegisterViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
}

extension RegisterViewController{
    func setupViewWhenShowKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardApear), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDisApear), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    @objc func keyboardApear(){
        view.frame.origin.y = 0
        view.frame.origin.y = view.frame.origin.y - 200
    }
    @objc func keyboardDisApear(){
        view.frame.origin.y = 0
    }
}
