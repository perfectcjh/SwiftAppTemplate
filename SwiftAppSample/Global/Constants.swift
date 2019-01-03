//
//  Constants.swift
//  SwiftAppSample
//
//  Created by cjh on 2019/1/3.
//  Copyright © 2019 perfectcjh. All rights reserved.
//

import UIKit

///  屏幕宽度
public let ScreenWidth : CGFloat = {
    return UIScreen.main.bounds.width
}()

/// 屏幕高度
public let ScreenHeight : CGFloat = {
    return UIScreen.main.bounds.height
}()

/// 当前机型是否是iPhoneX
public let IphoneX : Bool = {
    return ScreenHeight == 812 || ScreenHeight == 896
}()

/// 当前机型是否是小屏机iPhoneSE
public let IphoneSE : Bool = {
    return ScreenWidth < 350
}()

/// 屏幕顶部额外高度， iPhoneX 是24 其他为0
public let ScreenTopExtraOffset : CGFloat = {
    return IphoneX ? 24.0 : 0.0
}()

/// 屏幕第部额外高度， iPhoneX 是34 其他为0
public let ScreenBottomExtraOffset : CGFloat = {
    return IphoneX ? 34.0 : 0.0
}()

/// 导航栏高度
public let NavigationHeight: CGFloat = {
    return IphoneX ? 88.0 : 64.0
}()

/// 导航栏NavigationBar高度
public let NavigationBarHeight : CGFloat = 44.0

/// 状态栏StatusBar高度
public let StatusBarHeight : CGFloat = {
    return IphoneX ? 44.0 : 20.0
}()

/// TabBar高度
public let TabBarHeight : CGFloat = {
    return IphoneX ? 83.0 : 49.0
}()

/// 屏幕底部按钮适配
struct ScreenBottomBtnConstraint {
    static let leftSpace: CGFloat = IphoneX ? 15 : 0
    static let rightSpace: CGFloat = IphoneX ? 15 : 0
    static let bottomSpace: CGFloat = IphoneX ? 34 : 0
    static let height: CGFloat = 44
    static let cornerRadius: CGFloat = IphoneX ? 4 : 0
}
