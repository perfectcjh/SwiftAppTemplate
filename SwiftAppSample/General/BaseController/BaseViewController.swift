//
//  BaseViewController.swift
//  SwiftAppSample
//
//  Created by cjh on 2018/12/18.
//  Copyright © 2018 perfectcjh. All rights reserved.
//

import UIKit
import QMUIKit
import Closures

class BaseViewController: QMUICommonViewController {
    
    // 路由初始化参数
    var rounterParams : [String : Any]?
    
    /// Rounter 初始化方法
    required public init(rounterParams params: Dictionary<String, Any>?) {
        self.rounterParams = params
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(){
        super.init(nibName: nil, bundle: nil)
        self.rounterParams = nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        fd_prefersNavigationBarHidden = false
        view.backgroundColor = .vcBgColor
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        // 结束键盘事件
        view.endEditing(true)
    }
    
    override func setupNavigationItems() {
        if navigationController?.viewControllers.count != 1{
            let backItem = UIBarButtonItem.init(image: UIImage(named: "nav_back")?.withRenderingMode(.alwaysOriginal), style: .plain) { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
            backItem.imageInsets = UIEdgeInsets.init(top: 1, left: -9, bottom: -1, right: 9)
            navigationItem.leftBarButtonItem = backItem
        }
        super.setupNavigationItems()
    }
    
    deinit {
        DFPrint("===== \(self.classForCoder) deinit =====\n")
    }
}


extension BaseViewController {
    
    func makeViewNeverAdjustInsert() {
        if #available(iOS 11.0, *) {
            for subV in view.subviews {
                if let scrollV = subV as? UIScrollView {
                    scrollV.contentInsetAdjustmentBehavior = .never
                }
            }
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
    }
}

extension UIViewController {
    
    typealias AlertAction = () -> Void
    typealias AlertButton  = (title: String, action: AlertAction)
    
    func alert(title: String?, message: String, buttons: AlertButton...) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let actions = buttons.map { (title, action) in
            return  UIAlertAction(title: title, style: .default) { _ in
                action()
            }
        }
        
        actions.forEach { alert.addAction($0) }
        
        present(alert, animated: true, completion: nil)
    }
    
}
