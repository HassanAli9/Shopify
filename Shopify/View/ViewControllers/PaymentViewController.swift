//
//  PaymentViewController.swift
//  Shopify
//
//  Created by Islam Noureldin on 22/03/2022.
//

import UIKit

class PaymentViewController: UIViewController {

    @IBOutlet weak var copounTextfield: UITextField!
    @IBOutlet weak var cashOnDeliveryOption: UIButton!
    @IBOutlet weak var googlePayOption: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
      
    }

    private func checkCopoun(){
        let checkoutVC = self.storyboard?.instantiateViewController(withIdentifier: "CheckoutViewController") as! CheckoutViewController
        if copounTextfield.text == "shopify5" {
            checkoutVC.copoun = "5%"
        }
        else if copounTextfield.text == "shopify10"{
            checkoutVC.copoun = "10%"
            }
        else if copounTextfield.text == "shopify15"{
            checkoutVC.copoun = "15%"
        }else{
            checkoutVC.copoun = "No Discount"
        }
        if googlePayOption.isSelected{
            checkoutVC.paymentMethod = "Google Pay"
        }else{
            checkoutVC.paymentMethod = "Cash On delivery"
        }
        copounTextfield.text = ""
        navigationController?.pushViewController(checkoutVC, animated: false)
    }
    @IBAction func GooglePayOptionSelected(_ sender: Any) {
        setOptionSelection(_isGooglePaySelected: true)
    }
    
    @IBAction func cashOnDeliverySelected(_ sender: Any) {
    setOptionSelection(_isGooglePaySelected: false)
    }
    
    @IBAction func continueToCheckout(_ sender: Any) {
            checkCopoun()
    }
    func setOptionSelection(_isGooglePaySelected :Bool){
        if _isGooglePaySelected{
            
            self.googlePayOption.isSelected = true
            self.cashOnDeliveryOption.isSelected = false
        }else{
            self.googlePayOption.isSelected = false
            self.cashOnDeliveryOption.isSelected = true
        }
    }
}
