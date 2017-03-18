//
//  SCXViewModel.swift
//  swiftWB
//
//  Created by 孙承秀 on 16/12/14.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

import UIKit

class SCXViewModel: NSObject {

    var userInfoModel : SCXUserInfo?        //用户数据模型
    
    /// 处理后的时间字符串
    var dateStr : String?
    
    /// 处理后的微博来源字符串
    var sourcesStr : String?
    
    /// 处理用户会员等级
    var vipImage : UIImage?
    
    /// 处理用户认证
    var verifiedImage : UIImage?
    
    /// 处理用户头像的地址
    var profileURL : NSURL?
    
    /// 富文本微博消息
    var wbAttributeText : NSAttributedString?
    
    var wbTextHeiget : CGFloat?
    
    
    
    
    /// 构造函数，处理用户信息，将用户的一些数据最简单画保存，直接使用
    init(userInfoModel : SCXUserInfo) {
       self.userInfoModel = userInfoModel
        
        /// 判断来源是否为nil何是否为空
        if let sources = userInfoModel.source , sources != "" {
            
            /// 当来源字符串存在的时候
            let startIndex = (sources as NSString).range(of: ">").location + 1
            let endIndex = (sources as NSString).range(of: "</").location
            let length = endIndex - startIndex
            
            let range = NSRange(location: startIndex, length: length)
            sourcesStr = (sources as NSString).substring(with: range)
        }
        if let createStr = userInfoModel.created_at {
            /// 当时间字符串存在的时候，进行处理
            dateStr = NSDate.handleTimeWithTimeStr(dateStr: createStr)
        }
        
        /// 处理用户认证等级
        let verifiedType = userInfoModel.user?.verified_type ?? -1
        switch verifiedType {
        case 0:
            verifiedImage = UIImage(named: "avatar_vip")
            case 2,3,5 :
            verifiedImage = UIImage(named: "avatar_enterprise_vip")
        case 220:
            verifiedImage = UIImage(named: "avatar_grassroot")
        default:
            verifiedImage = nil
        }
        
        /// 用户会员等级
        let mbRank = userInfoModel.user?.mbrank ?? 0
        if mbRank > 0 && mbRank <= 6 {
            vipImage = UIImage(named: "common_icon_membership_level\(mbRank)")
        }
        
        /// 处理微博消息，将他转化为富文本，可设置高亮关键字
        if let attributeString = userInfoModel.text {
            // 将微博消息转化为富文本
            wbAttributeText = WBTextTool.attributeStringWithStringAndKeyWord(textString: attributeString, keyWord: "@")
            // 计算微博的高度
            wbTextHeiget = wbAttributeText?.heightWithTextWidth(textWidth: SCREEN_WIDTH - 10)
        }
        
        // 5.用户头像的处理
        let profileURLString = userInfoModel.user?.profile_image_url ?? ""
        profileURL = NSURL(string: profileURLString)
        
    }
}
