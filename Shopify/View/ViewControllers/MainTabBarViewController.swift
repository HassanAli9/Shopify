//
//  MainTabBarViewController.swift
//  Shopify
//
//  Created by Omar Ahmed on 18/03/2022.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    let guestVC = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "guestNC")
    let homeVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "ss")
    let categoryVC = UIStoryboard(name: "Categories", bundle: nil).instantiateViewController(withIdentifier: "categoryNC")
    let profileVC = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "profileNC")
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        homeVC.title = "Home"
        categoryVC.title = "Categories"
        profileVC.title = "My Profile"
        guestVC.title = "My Profile"
        
//        checkScreens(isLogged: checkUser)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let checkUser = Helper.shared.getUserStatus()

        checkScreens(isLogged: checkUser)
        
        guard let items = self.tabBar.items else {return}
        
        

        let images = ["homekit","rectangle.3.group.fill","person.circle.fill"]

        for x in 0...2{
            items[x].image = UIImage(systemName: images[x])
        }
        
        let unselectedColor = UIColor.systemTeal ;
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: unselectedColor], for: .selected)
        tabBar.tintColor = .systemTeal
    }
    
    
    
    func checkScreens(isLogged:Bool){
        if isLogged {
            self.setViewControllers([homeVC,categoryVC,profileVC], animated: true)

        }else{
            self.setViewControllers([homeVC,categoryVC,guestVC], animated: true)
        }
    }
    

}
