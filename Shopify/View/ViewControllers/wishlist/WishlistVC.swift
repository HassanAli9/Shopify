//
//  WishlistVC.swift
//  Shopify
//
//  Created by Hassan on 19/03/2022.
//

import UIKit

class WishlistVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(WishlistTVCell.nib(), forCellReuseIdentifier: WishlistTVCell.identifier)
        
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
