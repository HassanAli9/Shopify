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
        self.showActivityIndicator(indicator: indicator, startIndicator: true)
        guard let email = emailTextField.text, let password = passwordTextField.text else {return}
        loginViewModel.checkUserIsLogged(email: email, password: password) { customerLogged in
            self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
            if customerLogged != nil {
                print("success to login")
            }else{
                print("failed to login")
            }
        }
    }
}
