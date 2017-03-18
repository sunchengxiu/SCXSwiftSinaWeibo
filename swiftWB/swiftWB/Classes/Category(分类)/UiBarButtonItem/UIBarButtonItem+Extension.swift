//
//  UIBarButtonItem+Extension.swift
//  swiftWB
//
//  Created by 孙承秀 on 16/11/11.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

import UIKit

// MARK: - 设置UIBarButtonItem，传入正常状态和选中状态下的图片
extension UIBarButtonItem {
    convenience init(nomalImageName : String , hightImageName : String) {
        self.init()
        let btn : UIButton = UIButton()
        btn.setBackgroundImage(UIImage(named:nomalImageName), for: .normal)
        
        btn.setBackgroundImage(UIImage(named:hightImageName), for: .normal)
        btn.sizeToFit()
        self.customView = btn
    }

}
