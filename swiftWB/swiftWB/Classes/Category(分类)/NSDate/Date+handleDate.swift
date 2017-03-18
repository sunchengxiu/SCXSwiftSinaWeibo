//
//  Date+handleDate.swift
//  日期校验
//
//  Created by 孙承秀 on 16/12/7.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

import Foundation
extension NSDate {

    
    /// 时间处理
    ///
    /// - Parameter dateStr: 时间字符串
    /// - Returns: 处理好的时间
    class func handleTimeWithTimeStr(dateStr : String) -> String {
        // 创建日期格式
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE MM dd HH:mm:ss z yyyy"
        dateFormatter.locale = NSLocale(localeIdentifier: "en") as Locale!
        // 转化为时间
        guard let createDate = dateFormatter.date(from: dateStr) else {
            return ""
        }
        let currentDate = Date()
        // 计算两个时间的时间差
        let timeInterval = Int(currentDate.timeIntervalSince(createDate))
        
        // 打印时间差
        if timeInterval < 60 {
            return "刚刚"
        }
        if timeInterval < 60*60 {
            return "\(timeInterval / 60 )分钟前"
        }
        if timeInterval < 60 * 60 * 24 {
            return "\(timeInterval/60/60)小时前"
        }
        let calendar  = NSCalendar.current
        if calendar.isDateInYesterday(createDate) {
            dateFormatter.dateFormat = "昨天 HH:mm"
            let timeStr = dateFormatter.string(from: createDate)
            return timeStr
        }
        let comps = calendar.dateComponents([.year , .day , .month], from: createDate, to: currentDate as Date)
        if comps.day! < 7, comps.month == 0, comps.year == 0{
            if calendar.isDateInYesterday(createDate) {
                dateFormatter.dateFormat = "昨天 HH:mm"
                let timeStr = dateFormatter.string(from: createDate)
                return timeStr
            }
            else{
                dateFormatter.dateFormat = "一周内 MM-dd HH:mm"
                let timeStr = dateFormatter.string(from: createDate)
                return timeStr
            }
        }
        if comps.month! < 1 , comps.year == 0 {
            dateFormatter.dateFormat = "一个月内 MM-dd HH:mm"
            let timeStr = dateFormatter.string(from: createDate)
            return timeStr
        }
        
        if comps.year! < 1 {
            dateFormatter.dateFormat = "今年 MM-dd HH:mm"
            let timeStr = dateFormatter.string(from: createDate)
            return timeStr
        }
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let timeStr = dateFormatter.string(from: createDate)
        return timeStr
    }

}
