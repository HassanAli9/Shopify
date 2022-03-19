//
//  CreateAddressVC.swift
//  Shopify
//
//  Created by Hassan on 16/03/2022.
//

import UIKit

class CreateAddressVC: UIViewController {
    @IBOutlet var addAddressBtn: UIButton!
 
    @IBOutlet var countryTxt: UITextField!
    
    @IBOutlet var cityTxt: UITextField!
    
    @IBOutlet var AddressTxt: UITextField!
    
    @IBOutlet var phoneTxt: UITextField!
    
    let addressViewModel:CreateAddressVM = CreateAddressVM()
    override func viewDidLoad() {
        super.viewDidLoad()
      
        custmoizeTextField()
        // custmoizeBtn()
    }
    
    func custmoizeTextField() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: countryTxt.frame.height - 1, width: countryTxt.frame.width - 30, height: 1.0)
        bottomLine.backgroundColor = UIColor.gray.cgColor
        countryTxt.borderStyle = UITextField.BorderStyle.none
        countryTxt.layer.addSublayer(bottomLine)
        
        let bottomLine2 = CALayer()
        bottomLine2.frame = CGRect(x: 0.0, y: countryTxt.frame.height - 1, width: countryTxt.frame.width - 30, height: 1.0)
        bottomLine2.backgroundColor = UIColor.gray.cgColor
        cityTxt.borderStyle = UITextField.BorderStyle.none
        cityTxt.layer.addSublayer(bottomLine2)
        
        let bottomLine3 = CALayer()
        bottomLine3.frame = CGRect(x: 0.0, y: countryTxt.frame.height - 1, width: countryTxt.frame.width - 30, height: 1.0)
        bottomLine3.backgroundColor = UIColor.gray.cgColor
        AddressTxt.borderStyle = UITextField.BorderStyle.none
        AddressTxt.layer.addSublayer(bottomLine3)
        
        let bottomLine1 = CALayer()
        bottomLine1.frame = CGRect(x: 0.0, y: countryTxt.frame.height - 1, width: countryTxt.frame.width - 30, height: 1.0)
        bottomLine1.backgroundColor = UIColor.gray.cgColor
        phoneTxt.borderStyle = UITextField.BorderStyle.none
        phoneTxt.layer.addSublayer(bottomLine1)
    }
    
    func custmoizeBtn() {
        addAddressBtn.backgroundColor = .clear
        addAddressBtn.layer.cornerRadius = 5
        addAddressBtn.layer.borderWidth = 1
        addAddressBtn.layer.borderColor = UIColor.tintColor.cgColor
    }
    
    @IBAction func addAddressBtn(_ sender: Any) {
       
        let titleMessage = "Missing Data"
        if countryTxt.text == "" {
            showAlertErrro(title: titleMessage, message: "Please enter your country name")
        }
            
        if cityTxt.text == "" {
            showAlertErrro(title: titleMessage, message: "Please enter your city name")
        }
            
        if AddressTxt.text == "" {
            showAlertErrro(title: titleMessage, message: "Please enter your address")
        }
            
        if phoneTxt.text == "" {
            showAlertErrro(title: titleMessage, message: "Please enter you phone number")
                
        } else {
            let check: Bool = validate(value: phoneTxt.text!)
            if check == false {
                showAlertErrro(title: "invalid data!", message: "please enter you phone number in correct format")
            }
        }

        let address = Address(address: AddressTxt.text!, city: cityTxt.text!, phone: phoneTxt.text!, country: countryTxt.text!)
        
        var arr:[Address] = []
        arr.append(address)
      
        let custAddress =  CustomerAddress.init(addresses: arr)
        let network:Networking = Networking()
        network.postAddress(address: custAddress)
        
        addressViewModel.createAddress(custAddress: custAddress)
    }

    func checkData() {
        let titleMessage = "Missing Data"
        if countryTxt.text == "" {
            showAlertErrro(title: titleMessage, message: "Please enter your country name")
        }
            
        if cityTxt.text == "" {
            showAlertErrro(title: titleMessage, message: "Please enter your city name")
        }
            
        if AddressTxt.text == "" {
            showAlertErrro(title: titleMessage, message: "Please enter your address")
        }
            
        if phoneTxt.text == "" {
            showAlertErrro(title: titleMessage, message: "Please enter you phone number")
                
        } else {
            let check: Bool = validate(value: phoneTxt.text!)
            if check == false {
                showAlertErrro(title: "invalid data!", message: "please enter you phone number in correct format")
            }
        }
    }

    func validate(value: String) -> Bool {
        let PHONE_REGEX = "^\\d{1}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result = phoneTest.evaluate(with: value)
        print("RESULT \(result)")
        return result
    }
    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */
}
