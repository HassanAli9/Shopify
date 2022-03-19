//
//  GuestProfileViewController.swift
//  Shopify
//
//  Created by Omar Ahmed on 16/03/2022.
//

import UIKit

class GuestProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    @IBAction func navigateToLogIn(_ sender: Any) {
        let loginScreen = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
        loginScreen.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(loginScreen, animated: true)
    }
    
    @IBAction func navigateToRegister(_ sender: Any) {
        let registerScreen = UIStoryboard(name: "Register", bundle: nil).instantiateViewController(withIdentifier: "RegisterViewController")
        registerScreen.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(registerScreen, animated: true)
    }
    

}
