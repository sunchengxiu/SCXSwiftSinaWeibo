//
//  SCXAccountTool.swift
//  swiftWB
//
//  Created by 孙承秀 on 16/11/27.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

import UIKit

/// 工具类，用来读取沙盒判断用户是否成功登陆
class SCXAccountTool {

    /// 单例
    static let shareInstance :SCXAccountTool = SCXAccountTool()
    
    /// 设置用户信息存储路径,通过计算属性方式
    var accountPath : String {
        let accountPath =  NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return (accountPath as NSString).appendingPathComponent("account.plist")
    }
    
    /// 用户信息模型
    var account : SCXAccessModel?
    
    /// 判断用户是否登录
    var isLogin : Bool {
    
        if account == nil {
            return false
        }
        if account?.access_token == nil {
            return false
        }
        if account?.expires_date == nil {
            return false
        }
        return account?.expires_date?.compare(NSDate() as Date) == .orderedDescending
    }
    
    
    /// 重写系统init
    init(){
        account = NSKeyedUnarchiver.unarchiveObject(withFile: accountPath) as! SCXAccessModel?
    }
    
    
    
    
}
