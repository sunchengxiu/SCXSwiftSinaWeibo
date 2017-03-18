//
//  UIButton+Extension.swift
//  swiftWB
//
//  Created by 孙承秀 on 16/11/9.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

import UIKit
// MARK:-UIButton类别
extension UIButton{

    /// 便利构造函数
    ///
    /// - returns: UIButton
    convenience init(imageName:String, seleImageName:String, backgroundImageName:String, seleBackgroundImageName:String) {
        //必须显示的写出self.init()
        self.init()
        setImage(UIImage(named: imageName), for: .normal)
        setImage(UIImage(named: seleImageName), for: .highlighted)
        setBackgroundImage(UIImage(named:backgroundImageName), for: .normal)
        setBackgroundImage(UIImage(named:seleBackgroundImageName), for: .highlighted)
    }

}
