//
//  AddressVC+TVC.swift
//  Shopify
//
//  Created by Hassan on 16/03/2022.
//

import UIKit

extension AddressVC : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrOfAddress.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddressTVCell.identifier, for: indexPath) as! AddressTVCell
       let address = self.arrOfAddress[indexPath.row]
        if let addres1 = address.address1, let city = address.city, let country = address.country{
            cell.addressLabel.text = "\(addres1), \(city), \(country)"
        }
        return cell
    }
}

extension AddressVC : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
       
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "selected address to added in order"
    }
}
