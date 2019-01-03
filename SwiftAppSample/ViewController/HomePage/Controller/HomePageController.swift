//
//  HomePageController.swift
//  SwiftAppSample
//
//  Created by cjh on 2018/12/18.
//  Copyright © 2018 perfectcjh. All rights reserved.
//

import UIKit

class HomePageController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addTapGesture { (_) in
            let router = try! ServiceLocator.resolve() as MiniRouter
            router.open(route: "SwiftApp://test", params: nil)
        }
    }
    
}
