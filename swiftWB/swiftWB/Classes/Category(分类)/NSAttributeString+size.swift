//
//  NSAttributeString+size.swift
//  swiftWB
//
//  Created by 孙承秀 on 16/12/29.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

import UIKit
extension NSAttributedString{

    
    /// 计算一段文字的高度
    ///
    /// - Parameter textWidth: 文字的宽度
    /// - Returns: 文字的高度
    func heightWithTextWidth(textWidth : CGFloat) -> (CGFloat) {
        let  attribute : NSAttributedString? = self
        SCXLog(meassage: attribute == nil)
        SCXLog(meassage: !self.isKind(of: NSAttributedString.self ))
        guard attribute != nil && self.isKind(of: NSAttributedString.self ) else {
            
            return 0
        }
        return self.boundingHeightForWidth(width: textWidth)
    }
    
    /// 计算一段文字的高度
    ///
    /// - Parameter width: 文字的宽度
    /// - Returns: 这段文字的高度
    func boundingHeightForWidth(width : CGFloat) -> (CGFloat) {
        return self.boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil).size.height + 3
    }
}
