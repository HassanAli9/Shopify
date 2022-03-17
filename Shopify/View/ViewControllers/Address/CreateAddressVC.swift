//
//  CreateAddressVC.swift
//  Shopify
//
//  Created by Hassan on 16/03/2022.
//

import UIKit

class CreateAddressVC: UIViewController {

    @IBOutlet weak var addAddressBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        addAddressBtn.backgroundColor = .clear
        addAddressBtn.layer.cornerRadius = 5
        addAddressBtn.layer.borderWidth = 1
        addAddressBtn.layer.borderColor = UIColor.tintColor.cgColor    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
