//
//  AppDelegate+Rounts.swift
//  SwiftAppSample
//
//  Created by cjh on 2018/12/25.
//  Copyright © 2018 perfectcjh. All rights reserved.
//

import Foundation

extension AppDelegate {
    
    func registeRouters() {
        
        let router = try! ServiceLocator.resolve() as MiniRouter
        
        router.register(route: "SwiftApp://test") { (url) in UIViewController.topMost?.navigationController?.pushViewController(TestController(), animated: true)
        }
    }
    
}
