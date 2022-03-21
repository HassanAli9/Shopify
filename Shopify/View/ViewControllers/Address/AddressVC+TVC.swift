//
//  AddressVC+TVC.swift
//  Shopify
//
//  Created by Hassan on 16/03/2022.
//

import Foundation
import UIKit

extension AddressVC : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddressTVCell.identifier, for: indexPath) as! AddressTVCell
        
        
        
        cell.actionBlock = {
          cell.radioBtn.isOn = false
        }
        
        return cell
    }
    
    
}

extension AddressVC : UITableViewDelegate
{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
  

  
}
