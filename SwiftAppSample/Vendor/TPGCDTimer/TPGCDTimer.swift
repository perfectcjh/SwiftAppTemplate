//
//  TPGCDTimer.swift
//  FreeNAS
//
//  Created by chenjinheng on 2018/6/27.
//  Copyright © 2018年 refineit. All rights reserved.
//

import UIKit

class TPGCDTimer: NSObject {
    
    typealias ActionBlock = () -> Void
    static let shared = TPGCDTimer.init()
    lazy var timerContainer = [String: DispatchSourceTimer]()
    
    // GCD定时器
    func scheduledDispatchTimer(name: String,
                                timeInterval: Double,
                                queue: DispatchQueue? = DispatchQueue.init(label: "TPGCDTimer_Queue"),
                                repeats: Bool? = false,
                                action: ActionBlock? = nil) {
        
        var timer = timerContainer[name]
        if timer == nil {
            timer = DispatchSource.makeTimerSource(flags: [], queue: queue)
            timer?.resume()
            timerContainer[name] = timer
        }
        
        timer?.schedule(deadline: .now(), repeating: timeInterval, leeway: DispatchTimeInterval.milliseconds(100))
        timer?.setEventHandler(handler: { [weak self] in
            action?()
            if repeats == false {
                self?.cancleTimer(name: name)
            }
        })
    }
    
    // 取消定时器
    func cancleTimer(name: String) {
        let timer = timerContainer[name]
        if timer == nil {
            return
        }
        timerContainer.removeValue(forKey: name)
        timer?.cancel()
    }
    
    
    // 检查定时器是否已存在
    func isExistTimer(name: String) -> Bool {
        if timerContainer[name] != nil {
            return true
        }
        return false
    }
    
}
