//
//  CheckoutViewController.swift
//  Shopify
//
//  Created by Islam Noureldin on 21/03/2022.
//

import UIKit

class CheckoutViewController: UIViewController {

    @IBOutlet weak var checkoutTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        checkoutTableView.dataSource = self
        checkoutTableView.delegate = self
        checkoutTableView.register(OrdersTVC.nib(), forCellReuseIdentifier: OrdersTVC.identifier)
    }
}
extension CheckoutViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let checkoutCell = tableView.dequeueReusableCell(withIdentifier: OrdersTVC.identifier) as! OrdersTVC
        return checkoutCell
    }
    
    
}
extension CheckoutViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height*0.4
    }
}
