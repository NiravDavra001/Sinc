//
//  TabbarViewController.swift
//  sinc
//
//  Created by mac on 02/03/21.
//

import UIKit

class TabbarViewController: UITabBarController ,UITabBarControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    
    func setUpUI(){
        tabBar.items?.first?.image = UIImage(named: "IconSwipe")
        tabBar.items?[2].image = UIImage(named: "IconProfile")
        tabBar.items?[1].image = UIImage(named: "IconMsg")
        tabBar.items?[3].image = UIImage(named: "SettingIcon")
        
        tabBar.items?.first?.title = "Swipe"
        tabBar.items?[2].title = "Profile"
        tabBar.items?[1].title = "Message"
        tabBar.items?[3].title = "Setting"
        
//        tabBar.items?.first?.image = UIImage(named: "IconSwipe_selected")
//        tabBar.items?[2].image = UIImage(named: "IconProfile_selected")
//        tabBar.items?[1].image = UIImage(named: "IconMsg_selected")
//        tabBar.items?[3].image = UIImage(named: "SettingIcon_selected")
        
        tabBar.tintColor = .appDarkGreen
        
        
    }
    

}
