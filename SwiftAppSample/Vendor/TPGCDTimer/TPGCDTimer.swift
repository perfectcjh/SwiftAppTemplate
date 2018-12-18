//
//  TPGCDTimer.swift
//  FreeNAS
//
//  Created by chenjinheng on 2018/6/27.
//  Copyright © 2018年 refineit. All rights reserved.
//

import UIKit

typealias ActionBlock = () -> ()

class TPGCDTimer: NSObject {
    
    static let shared = TPGCDTimer.init()

    lazy var timerContainer = [String: DispatchSourceTimer]()
    
    // GCD定时器
    func scheduledDispatchTimer(WithTimerName name: String?, timeInterval: Double, queue: DispatchQueue, repeats: Bool, action: @escaping ActionBlock) {
        
        if name == nil {
            return
        }
        
        var timer = timerContainer[name!]
        if timer == nil {
            timer = DispatchSource.makeTimerSource(flags: [], queue: queue)
            timer?.resume()
            timerContainer[name!] = timer
        }
        
        timer?.schedule(deadline: .now(), repeating: timeInterval, leeway: DispatchTimeInterval.milliseconds(100))
        timer?.setEventHandler(handler: { [weak self] in
            action()
            if repeats == false {
                self?.cancleTimer(name)
            }
        })
    }
    
    // 取消定时器
    func cancleTimer(_ name: String?) {
        let timer = timerContainer[name!]
        if timer == nil {
            return
        }
        timerContainer.removeValue(forKey: name!)
        timer?.cancel()
    }
    
    
    // 检查定时器是否已存在
    func isExistTimer(_ name: String?) -> Bool {
        if timerContainer[name!] != nil {
            return true
        }
        return false
    }
    
}
