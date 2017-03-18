//
//  SCXAccessModel.swift
//  swiftWB
//
//  Created by 孙承秀 on 16/11/26.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

import UIKit

class SCXAccessModel: NSObject , NSCoding {

    var expires_in : TimeInterval  = 0.0 {
    
        didSet{
            /// 设置过期时间,转化成nsdate类型
            expires_date = NSDate(timeIntervalSinceNow: expires_in)
        }
    
    }
    
    var access_token : String?
    
    var uid : String?
    
    var expires_date : NSDate?
    
    /// 用户头像，大图
    var avatar_large : String?
    
    ///用户昵称
    var screen_name : String? 
    
    
    ///重写系统的方法，防止赋值不存在的键
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    ///kvc赋值
    init(dict : [String : AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    // 重写系统description，打印model内容
    override var description: String {
    
        return dictionaryWithValues(forKeys: ["access_token","uid","expires_in" , "avatar_large" , "screen_name"]).description
    
    }
    override init() {
        super.init()
    }
    /// 解档
    required init?(coder aDecoder: NSCoder) {
        access_token = aDecoder.decodeObject(forKey: "access_token") as! String?
        uid = aDecoder.decodeObject(forKey: "uid") as! String?
        expires_date = aDecoder.decodeObject(forKey: "expires_date") as! NSDate?
        avatar_large = aDecoder.decodeObject(forKey: "avatar_large") as! String?
        screen_name = aDecoder.decodeObject(forKey: "screen_name") as! String?
    }
    
    /// 归档
    func encode(with aCoder: NSCoder) {
        aCoder.encode(screen_name, forKey: "screen_name")
        aCoder.encode(access_token, forKey: "access_token")
        aCoder.encode(uid, forKey: "uid")
        aCoder.encode(expires_date, forKey: "expires_date")
        aCoder.encode(avatar_large, forKey: "avatar_large")
    }
}
