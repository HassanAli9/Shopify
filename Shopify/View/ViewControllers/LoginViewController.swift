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
    let loginViewModel = LoginViewModel()
    let indicator = NVActivityIndicatorView(frame: .zero, type: .ballClipRotateMultiple, color: .black, padding: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func loginDidPressed(_ sender: UIButton) {
        login()
    }
    
    @IBAction func moveToSignUpPageDidPressed(_ sender: UIButton) {
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
            self.showAlertErrro(title: "please fill your infromation to login", message: "for login must fill all information")
            return
        }
        loginViewModel.checkUserIsLogged(email: email, password: password) { customerLogged in
            DispatchQueue.main.async {
                self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
            }
            if customerLogged != nil {
                print("success to login")
            }else{
                self.showAlertErrro(title: "failed to login", message: "please check your email or password")
                print("failed to login")
            }
        }
    }
}
