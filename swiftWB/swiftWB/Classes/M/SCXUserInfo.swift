//
//  SCXUserInfo.swift
//  swiftWB
//
//  Created by 孙承秀 on 16/12/7.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

import UIKit
class SCXUserInfo: NSObject {

    
    /// 创建时间
    var created_at : String?  {
        didSet{
            
            
        }
    }
    
    /// 微博ID
    var id : Int = 0
    
    /// 微博MID
    var mid : Int = 0
    
    /// 微博消息
    var text : String?
    
    /// 微博来源
    var source : String?
    
    /// user数据
    var user : SCXUserModel?
    
    
    override init() {
        super.init()
    }
    init(dict : [String : AnyObject]) {
        super.init()
        
        setValuesForKeys(dict)
        
        if let userDic = dict["user"] as? [String : AnyObject]{
            user = SCXUserModel(dict: userDic )
        }
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
