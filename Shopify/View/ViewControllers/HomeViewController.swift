//
//  HomeViewController.swift
//  Shopify
//
//  Created by Nasr on 13/03/2022.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var homeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView(){
        homeTableView.register(HomeTableViewCell.Nib(), forCellReuseIdentifier: HomeTableViewCell.identifier)
        homeTableView.register(BrandsTableViewCell.Nib(), forCellReuseIdentifier: BrandsTableViewCell.identifier)
        homeTableView.delegate = self
        homeTableView.dataSource = self
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows = 0
        switch section{
        case 0:
            rows = 1
        default:
            rows = 1
        }
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let adsCell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath)
            return adsCell
        default:
            let brandCell = tableView.dequeueReusableCell(withIdentifier: BrandsTableViewCell.identifier, for: indexPath)
            return brandCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = 0.0
        switch indexPath.section{
        case 0:
            height = 210
        default:
            height = view.frame.height
        }
        return height
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title = ""
        switch section{
        case 0:
            title = "Ads"
        default:
            title = "Brands"
        }
        return title
    }
}
