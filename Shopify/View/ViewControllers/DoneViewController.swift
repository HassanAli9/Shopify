//
//  DoneViewController.swift
//  Shopify
//
//  Created by Omar Ahmed on 24/03/2022.
//

import UIKit

class DoneViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func continueShoppingBtn(_ sender: Any) {
        UIApplication.shared.keyWindow?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarViewController")
    }
}
