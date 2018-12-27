//
//  BaseNavigationController.swift
//  SwiftAppSample
//
//  Created by cjh on 2018/12/18.
//  Copyright © 2018 perfectcjh. All rights reserved.
//

import UIKit
import QMUIKit

class BaseNavigationController: QMUINavigationController {
    
    /// 如果是Nav嵌套TabBar通过该值判断调用那个跳转，否则忽略
    var isTabBarNav = false

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if let rootVC = appDelegate.window?.rootViewController as? RootViewController,
            let nav = rootVC.rootTabBar.navigationController,
            isTabBarNav {
            nav.pushViewController(viewController, animated: animated)
        }else{
            super.pushViewController(viewController, animated: animated)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.topViewController?.preferredStatusBarStyle ?? .default
    }
}
