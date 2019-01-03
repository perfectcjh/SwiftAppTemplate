//
//  AppDelegate+Service.swift
//  SwiftAppSample
//
//  Created by cjh on 2018/12/25.
//  Copyright © 2018 perfectcjh. All rights reserved.
//

import Foundation
import Dip

extension AppDelegate {
    
    func configureServiceLocator(_ locator: DependencyContainer) {
        // 路由服务
        locator.register(.singleton) { MiniRouter() as MiniRouter }
    }
}
