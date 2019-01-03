//
//  AppDelegate.swift
//  SwiftAppSample
//
//  Created by cjh on 2018/12/12.
//  Copyright © 2018 perfectcjh. All rights reserved.
//

import UIKit
import Dip

let appDelegate = UIApplication.shared.delegate as! AppDelegate
let ServiceLocator = appDelegate.dip

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let dip = DependencyContainer()
    var backgroundTask: UIBackgroundTaskIdentifier?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        configureServiceLocator(dip)
        configApp(application: application, launchOptions: launchOptions)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
        backgroundTask = UIApplication.shared.beginBackgroundTask(withName: "backgroundTask", expirationHandler: {
            UIApplication.shared.endBackgroundTask(self.backgroundTask!)
        })
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {

    }

}

extension AppDelegate {
    
    private func configApp(application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = RootViewController()
        window?.makeKeyAndVisible()
        
        registeRouters()
        
    }
    
}

