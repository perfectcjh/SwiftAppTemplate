//
//  UIColor+Extension.swift
//  SwiftAppSample
//
//  Created by cjh on 2019/1/3.
//  Copyright © 2019 perfectcjh. All rights reserved.
//

import UIKit

extension UIColor{
    
    ///  主题黄色
    static var mainYellowColor : UIColor {
        return UIColor(hex: 0xff8a00)
    }
    
    
    /// 浅黄色
    static var lightYellowColor : UIColor {
        return UIColor.init(red: 255, green: 239, blue: 220)
    }
    
    
    /// 分割色
    static var separatorColor : UIColor {
        return UIColor(hex: 0xdfdfdf)
    }
    
    /// 分割色
    static var disableColor : UIColor {
        return UIColor(hex: 0xbcbcbc)
    }
    
    /// 半透明颜色
    static var translucentColor : UIColor {
        return UIColor(hex: 0x000000, alpha: 0.6)
    }
    
    /// 红点颜色
    static var redDotColor : UIColor {
        return UIColor(hex: 0xFF411B, alpha: 1)
    }
    
    /// viewControler 背景颜色
    static var vcBgColor : UIColor {
        return UIColor(hex: 0xf4f4f4)
    }
    
    static var spaceColor : UIColor {
        return UIColor(hex: 0xF8F8F8)
    }
    
    /// 黑色
    static var mainBlackColor : UIColor {
        return UIColor(hex: 0x333333)
    }
}

extension UIColor{
    /// 随机色
    static var random: UIColor {
        let maxValue: UInt32 = 24
        return UIColor(red: CGFloat(arc4random() % maxValue) / CGFloat(maxValue),
                       green: CGFloat(arc4random() % maxValue) / CGFloat(maxValue) ,
                       blue: CGFloat(arc4random() % maxValue) / CGFloat(maxValue) ,
                       alpha: 1)
    }
    
    
    /// 便利构造函数
    ///
    /// - Parameters:
    ///   - red: red
    ///   - green: green
    ///   - blue: blue
    convenience init(red: UInt, green: UInt, blue: UInt) {
        
        self.init(red: CGFloat((red%255)) / 255.0, green: CGFloat((green%255)) / 255.0, blue: CGFloat((blue%255)) / 255.0, alpha: 1.0)
    }
    
    
    /// 十六进制颜色 - 可设置透明度
    ///
    /// - Parameters:
    ///   - hex: 十六进制
    ///   - alpha: 透明度
    convenience init(hex: Int, alpha: Float) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat.init(alpha)
        )
    }
    
    /// 十六进制颜色
    ///
    /// - Parameters:
    ///   - hex: 十六进制
    convenience init(hex:Int) {
        self.init(hex: hex, alpha: 1)
    }
    
}

extension UIColor {
    
    convenience init(r: Int, g: Int, b: Int, a: CGFloat) {
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: a)
    }
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex: Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
    
    @nonobjc class var randomColor:UIColor {
        get {
            let red = CGFloat(arc4random()%256)/255.0
            let green = CGFloat(arc4random()%256)/255.0
            let blue = CGFloat(arc4random()%256)/255.0
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    }
}

extension UIColor {
    
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}

