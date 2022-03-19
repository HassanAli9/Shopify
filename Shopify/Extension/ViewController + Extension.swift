//
//  ViewController + Extension.swift
//  Shopify
//
//  Created by Nasr on 16/03/2022.
//

import Foundation
import UIKit
import NVActivityIndicatorView

extension UIViewController{
    func showAlertErrro(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}

extension UIViewController {
    func showAlertSheet(title:String, message:String,complition:@escaping (Bool)->Void){
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let logOut = UIAlertAction(title: "Log out", style: .destructive) { _ in
            complition(true)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .default) { _ in
            complition(false)
        }
        actionSheet.addAction(logOut)
        actionSheet.addAction(cancel)
        self.present(actionSheet, animated: true, completion: nil)
    }
}

extension UIViewController{
    func showActivityIndicator(indicator: NVActivityIndicatorView? ,startIndicator: Bool){
        guard let indicator = indicator else {return}
        DispatchQueue.main.async {
            indicator.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(indicator)
            
            NSLayoutConstraint.activate([
                indicator.widthAnchor.constraint(equalToConstant: 40),
                indicator.heightAnchor.constraint(equalToConstant: 40),
                indicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                indicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            ])
        }
        
        
       
        

        if startIndicator{
            indicator.startAnimating()
        }else{
            indicator.stopAnimating()
        }
    }
}

extension UIViewController{
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}
