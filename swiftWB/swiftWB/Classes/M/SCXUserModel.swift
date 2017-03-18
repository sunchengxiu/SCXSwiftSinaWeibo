//
//  SCXUserModel.swift
//  swiftWB
//
//  Created by 孙承秀 on 16/12/14.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

import UIKit

class SCXUserModel: NSObject {

    // MARK:- 属性
    var profile_image_url : String?         // 用户的头像
    var screen_name : String?               // 用户的昵称
    var verified_type : Int = -1            // 用户的认证类型
    var mbrank : Int = 0                    // 用户的会员等级
    
    init(dict : [String : AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
