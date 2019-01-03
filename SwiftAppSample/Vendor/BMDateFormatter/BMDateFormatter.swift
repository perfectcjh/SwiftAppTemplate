//
//  BMDateFormatter.swift
//  BMBuyer
//
//  Created by cjh on 2018/12/22.
//  Copyright © 2018 shencai.cgs.com. All rights reserved.
//

import Foundation

enum BMDateFormatterStyle: String {
    
    case `default` = "yyyy-MM-dd HH:mm:ss"
    case style2 = "yyyy-MM-dd"
    case style3 = "yyyy年MM月dd日"
    case style4 = "yyyyMMdd"
    case style5 = "yyyyMMddHHmmss"
    case style6 = "HH:mm"
    case style7 = "HH:mm:ss"
    case style8 = "mm:ss"
    case style9 = "ss"
    case style10 = "yyyy.MM.dd"
    case style11 = "HHmmss"
    case style12 = "HH时mm分ss秒"
    case style13 = "MM月dd日 HH:mm"
    case style14 = "yyyy/MM/dd HH:mm"
    case style15 = "yyyy/MM/dd HH:mm:ss"
    
    // +8 时区
    var fmtter: DateFormatter {
        let fmtter = DateFormatter()
        fmtter.dateFormat = self.rawValue
        fmtter.locale = Locale.init(identifier: "zh_CN")
        return fmtter
    }
    
    // +0 时区
    var GMTFmtter: DateFormatter {
        let fmtter = DateFormatter()
        fmtter.dateFormat = self.rawValue
        return fmtter
    }
}


/// 日期格式化工具
struct BMDateFormatter {
    
    /// 字符串->日期
    static func toDate(string: String, style: BMDateFormatterStyle) -> Date? {
        return style.fmtter.date(from: string)
    }
    
    /// 日期->字符串
    static func toString(date: Date, style: BMDateFormatterStyle) -> String {
        return style.fmtter.string(from: date)
    }
    
    /// 时间戳->字符串
    static func toString(timeInterval: TimeInterval, style: BMDateFormatterStyle) -> String {
        return style.fmtter.string(from: Date.init(timeIntervalSince1970: timeInterval))
    }
    
    /// GMT 字符串->日期
    static func toGMTDate(string: String, style: BMDateFormatterStyle) -> Date? {
        return style.GMTFmtter.date(from: string)
    }
    
    /// GMT 日期->字符串
    static func toGMTString(date: Date, style: BMDateFormatterStyle) -> String {
        return style.GMTFmtter.string(from: date)
    }
    
    /// GMT 时间戳->字符串
    static func toGMTString(timeInterval: TimeInterval, style: BMDateFormatterStyle) -> String {
        return style.GMTFmtter.string(from: Date.init(timeIntervalSince1970: timeInterval))
    }
    
    
    /// 获取当前时间
    static func currentGMTTimeInterval() -> TimeInterval {
        return Date().timeIntervalSince1970
    }
    
    /// 剩余时间
    static func toString(remainTime: TimeInterval) -> String {
        guard remainTime > 0 else { return "00:00:00" }
    
        var remainTime = Int(remainTime)
        let hour = remainTime / 3600
        remainTime = remainTime % 3600
        let minute = remainTime / 60
        remainTime = remainTime % 60
        let second = remainTime
        
        let hourStr = hour < 10 ? "0\(hour)" : "\(hour)"
        let minuteStr = minute < 10 ? "0\(minute)" : "\(minute)"
        let secondStr = second < 10 ? "0\(second)" : "\(second)"
        return "\(hourStr):\(minuteStr):\(secondStr)"
    }
}
