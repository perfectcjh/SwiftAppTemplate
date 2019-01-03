//
//  RootTabBarController.swift
//  SwiftAppSample
//
//  Created by cjh on 2018/12/25.
//  Copyright © 2018 perfectcjh. All rights reserved.
//

import UIKit
import QMUIKit

class RootTabBarController: QMUITabBarViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        fd_prefersNavigationBarHidden = true
        
        setupTabbar()
    }
    
    private func setupTabbar() {
        let homeNav = BaseNavigationController(rootViewController: HomePageController())
        homeNav.isTabBarNav = true
        configTabbarItem(homeNav, "首页", UIImage.init(named: "tabbar_home_normal"), UIImage.init(named: "tabbar_home_selected"))
        
        let userNav = BaseNavigationController(rootViewController: UserCenterController())
        userNav.isTabBarNav = true
        configTabbarItem(userNav, "我的", UIImage.init(named: "tabbar_merchants_normal"), UIImage.init(named: "tabbar_merchants_selected"))
        
        viewControllers = [homeNav, userNav]
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: TabBarHeight))
        view.backgroundColor = UIColor.white
        self.tabBar.insertSubview(view, at: 0)
        self.tabBar.isOpaque = true
        self.tabBar.alpha = 1.0
    }

    private func configTabbarItem(_ vc: UIViewController, _ title: String, _ normal: UIImage?, _ selected: UIImage?) {
        vc.tabBarItem.title = title
        vc.tabBarItem.image = normal?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.selectedImage = selected?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 10), NSAttributedString.Key.foregroundColor : UIColor(hex: 0x333333) ], for: .selected)
        vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 10), NSAttributedString.Key.foregroundColor : UIColor(hex: 0x999999)], for: .normal)
    }
}

extension RootTabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
    
}
