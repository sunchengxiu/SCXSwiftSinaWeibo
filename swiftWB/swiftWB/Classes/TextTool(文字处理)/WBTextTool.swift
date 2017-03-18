//
//  WBTextTool.swift
//  swiftWB
//
//  Created by 孙承秀 on 16/12/28.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

import UIKit

class WBTextTool: NSObject {
    
    
   
}

// MARK: - 有关文字大小宽度高度处理
extension WBTextTool {

    


}

// MARK: - 文字字符特殊处理
extension WBTextTool {

    /// 公共富文本，设置高亮
    ///
    /// - Parameters:
    ///   - textString: 源字符串
    ///   - keyWord: 要特殊处理的字符
    /// - Returns: 处理后的富文本
    class func attributeStringWithStringAndKeyWord(textString : String , keyWord : String?) -> (NSAttributedString)  {
        
        return self.attributeStringWithStringAndKeyWordAndFontAndHighLightColorAndTextColor(textString: textString, keyWord: keyWord, textFont: UIFont.systemFont(ofSize: 16), highLightColor:  UIColor(colorLiteralRed: 1, green: 0.49, blue: 0.65, alpha: 1), textColor: UIColor(colorLiteralRed: 0.17, green: 0.23, blue: 0.28, alpha: 1))
    }
    
    /// 公共富文本，设置高亮
    ///
    /// - Parameters:
    ///   - textString: 源字符串
    ///   - keyWord: 要特殊处理的字符
    ///   - textFont: 字体大小
    ///   - highLightColor: 处理字体的高亮颜色
    ///   - textColor: 普通字体颜色
    /// - Returns: 处理后的富文本
    class func attributeStringWithStringAndKeyWordAndFontAndHighLightColorAndTextColor(textString : String , keyWord : String? , textFont : UIFont , highLightColor : UIColor , textColor : UIColor) -> (NSAttributedString) {
        return self.attributeStringWithStringAndKeyWordAndFontAndHighLightColorAndTextColorAndLineSpace(textString: textString, keyWord: keyWord, textFont: textFont, highLightColor: highLightColor, textColor: textColor, lineSpace: 10)
    }
    
    /// 公共富文本，设置高亮
    ///
    /// - Parameters:
    ///   - textString: 源字符串
    ///   - keyWord: 要特殊处理的字符
    ///   - textFont: 字体大小
    ///   - highLightColor: 处理字体的高亮颜色
    ///   - textColor: 普通字体颜色
    ///   - lineSpace: 字体和字体之间的行高
    /// - Returns: 处理后的富文本
    class func attributeStringWithStringAndKeyWordAndFontAndHighLightColorAndTextColorAndLineSpace(textString : String , keyWord : String? , textFont : UIFont , highLightColor : UIColor , textColor : UIColor , lineSpace : CGFloat) -> (NSAttributedString) {
        let attributeString : NSMutableAttributedString = NSMutableAttributedString(string: textString)
        let text : NSString = (keyWord as NSString?)!
        
        let keyWord = keyWord
        // 如果关键字不存在的时候,就当做全部为关键作做没有关键字的处理就是默认处理
        if keyWord == nil || keyWord == "" || text.length == 0{
            let range : NSRange = NSRange(location: 0, length: attributeString.length)
            // 给富文本添加属性
            attributeString.addAttribute(NSFontAttributeName, value: textFont, range: range)
            attributeString.addAttribute(NSForegroundColorAttributeName, value: textColor, range: range)
            let style = NSMutableParagraphStyle()
            style.lineSpacing = lineSpace
            attributeString.addAttribute(NSParagraphStyleAttributeName, value: style, range: range)
            return attributeString
        }
        else{
            let text : NSString = (textString as NSString?)!
            
            /// 关键字range
            let  range : NSRange = text.range(of: keyWord!, options: .caseInsensitive)
            
            /// 所有字符range
            let  allRange : NSRange = NSRange(location: 0, length: attributeString.length)
            // 如果找到了，就设置关键字颜色
            if range.location != NSNotFound {
                
                attributeString.addAttribute(NSForegroundColorAttributeName, value: textColor, range: allRange)
                
                attributeString.addAttribute(NSForegroundColorAttributeName, value: highLightColor, range: range)
                attributeString.addAttribute(NSFontAttributeName, value: textFont, range: allRange)
                let style = NSMutableParagraphStyle()
                style.lineSpacing = lineSpace
                attributeString.addAttribute(NSParagraphStyleAttributeName, value: style, range: allRange)
                return attributeString
            }
            else{
                
                attributeString.addAttribute(NSForegroundColorAttributeName, value: textColor, range: allRange)
                attributeString.addAttribute(NSFontAttributeName, value: textFont, range: allRange)
                let style = NSMutableParagraphStyle()
                style.lineSpacing = lineSpace
                attributeString.addAttribute(NSParagraphStyleAttributeName, value: style, range: allRange)
                return attributeString
            }
        }
        
    }

}
