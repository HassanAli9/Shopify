//
//  LoginViewController.swift
//  Shopify
//
//  Created by Nasr on 15/03/2022.
//

import UIKit
import TextFieldEffects

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: MadokaTextField!
    @IBOutlet weak var passwordTextField: MadokaTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func loginDidPressed(_ sender: UIButton) {
    }
    
    @IBAction func moveToSignUpPageDidPressed(_ sender: UIButton) {
    }
}
