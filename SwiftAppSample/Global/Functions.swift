//
//  Functions.swift
//  SwiftAppSample
//
//  Created by cjh on 2019/1/3.
//  Copyright © 2019 perfectcjh. All rights reserved.
//

import UIKit
import AudioToolbox

///只在debug环境下打印, 携带文件信息
public func DFPrint(_ items: Any..., separator: String = " ", terminator: String = "\n", file: StaticString = #file, line: UInt = #line){
    
    
    #if DEBUG
    
    if let lastPath = file.description.components(separatedBy: "/").last{
        print("\(lastPath) line:\(line)", separator: "", terminator: ":  ")
    }else{
        print("\(file) line:\(line)", separator: "", terminator: ":  ")
    }
    
    items.forEach { (item) in
        print(item, separator: "", terminator: "")
        print(separator, separator: "", terminator: "")
    }
    
    print(terminator, separator: "", terminator: "")
    
    #endif
}

///只在debug环境下打印
public func DPrint(_ items: Any..., separator: String = " ", terminator: String = "\n"){
    
    
    #if DEBUG
    
    items.forEach { (item) in
        print(item, separator: "", terminator: "")
        print(separator, separator: "", terminator: "")
    }
    
    print(terminator, separator: "", terminator: "")
    
    #endif
}

/// 自适应
///
/// - Parameter size: <#size description#>
/// - Returns: <#return value description#>
public func kScale(_ size: CGFloat) -> CGFloat{
    return size / 375.0 * ScreenWidth
}


/// 播放滴滴声
public func PlayNoticeSound(){
    
    let fileUrl = NSURL.init(string: "/System/Library/Audio/UISounds/sms-received1.caf")!
    var sound  : SystemSoundID = 1
    _ =  AudioServicesCreateSystemSoundID(fileUrl, &sound)
    
    AudioServicesPlayAlertSoundWithCompletion(sound, nil)
}


/// 震动
public func VibratePhone(){
    AudioServicesPlaySystemSoundWithCompletion(kSystemSoundID_Vibrate, nil)
}

/// 压缩图片
public func CompressImageData(_ data: Data, to maxSize: Int) -> Data{
    
    guard data.count > maxSize else {
        return data
    }
    
    let quality: Float = Float(maxSize) / Float (data.count) * 0.9
    
    return UIImage(data: data)!.jpegData(compressionQuality: CGFloat(quality))!
}

/// 压缩图片
//public func CompressImage(_ image: UIImage, to maxSize: Int) -> Data{
//    return CompressImageData(image.data!, to: maxSize)
//}

// MARK: - 获取当前控制器

public func getCurrentViewController() -> UIViewController {
    let window: UIWindow = UIApplication.shared.keyWindow!
    let view: UIView? = window.subviews.first
    let frontView = getFrontViewFromWindow(view: view!)
    let responder: UIResponder? = frontView.next
    return getViewControllerResponder(responder: responder, window: window)
}
// MARK: - 查找最前方视图

public func getFrontViewFromWindow(view: UIView) -> UIView {
    
    if view.subviews.count == 0 {
        return view
    }
    let subView = view.subviews.first!
    return getFrontViewFromWindow(view: subView)
}

// MARK: - 查找最前方视图的viewController响应者

public func getViewControllerResponder(responder: UIResponder?, window: UIWindow) -> UIViewController {
    
    if let res = responder {
        if res.isKind(of: UIViewController.classForCoder()) {
            return res as! UIViewController
        }
    }
    guard let r = responder?.next else {
        return window.rootViewController!
    }
    if r.isKind(of: UIViewController.classForCoder()) {
        return r as! UIViewController
    }
    return getViewControllerResponder(responder: r, window: window)
}

public func vcFromString(_ vcName: String) -> UIViewController? {
    let nameSpace = Bundle.main.infoDictionary?["CFBundleName"] as! String
    guard let cls = NSClassFromString(nameSpace + "." + vcName) as? UIViewController.Type else {
        return nil
    }
    return cls.init()
}


