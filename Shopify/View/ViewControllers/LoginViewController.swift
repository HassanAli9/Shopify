//
//  LoginViewController.swift
//  Shopify
//
//  Created by Nasr on 15/03/2022.
//

import UIKit
import Alamofire
import TextFieldEffects
import NVActivityIndicatorView

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: MadokaTextField!
    @IBOutlet weak var passwordTextField: MadokaTextField!
    @IBOutlet weak var sinupLabel: UILabel!
    
    let loginViewModel = LoginViewModel()
    let indicator = NVActivityIndicatorView(frame: .zero, type: .ballClipRotateMultiple, color: .label, padding: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        self.hideKeyboardWhenTappedAround()
        setGestureOnSignUpLabel()
        setupViewWhenShowKeyboard()
        
        guard let id = Helper.shared.getUserID() else {return}
        print(" id\(id)")
    }
    @IBAction func loginDidPressed(_ sender: UIButton) {
        login()
    }
    
    @IBAction func moveToSignUpPageDidPressed(_ sender: UIButton) {
        goToRegisterPage()
    }
    
    func setGestureOnSignUpLabel(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(goToRegisterPage))
        sinupLabel.isUserInteractionEnabled = true
        sinupLabel.addGestureRecognizer(tapGesture)
    }
    
   @objc func goToRegisterPage(){
        let loginVc = UIStoryboard(name: "Register", bundle: nil).instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        
        self.navigationController?.pushViewController(loginVc, animated: true)
    }
}

extension LoginViewController{
    func login(){
        DispatchQueue.main.async {
            self.showActivityIndicator(indicator: self.indicator, startIndicator: true)
        }
        guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            DispatchQueue.main.async {
                self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
            }
            self.showAlertError(title: "please fill your infromation to login", message: "for login must fill all information")
            return
        }
        loginViewModel.checkUserIsLogged(email: email, password: password) { [self] customerLogged in
            DispatchQueue.main.async {
                self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
            }
            if customerLogged != nil {
                print("success to login")
                UIApplication.shared.keyWindow?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarViewController")
            }else{
                Helper.shared.setUserStatus(userIsLogged: false)
                self.showAlertError(title: "failed to login", message: "please check your email or password")
                print("failed to login")
            }
        }
    }
}

extension LoginViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
}

extension LoginViewController{
    func setupViewWhenShowKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardApear), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDisApear), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    @objc func keyboardApear(){
        view.frame.origin.y = 0
        view.frame.origin.y = view.frame.origin.y - 170
    }
    @objc func keyboardDisApear(){
        view.frame.origin.y = 0
    }
}
