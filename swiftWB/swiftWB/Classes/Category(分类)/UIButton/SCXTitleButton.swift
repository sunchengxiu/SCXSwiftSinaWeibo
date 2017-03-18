//
//  SCXTitleButton.swift
//  swiftWB
//
//  Created by 孙承秀 on 16/11/11.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

import UIKit

class SCXTitleButton: UIButton {

    /// 重写init方法，设置默认设置的东西
    override init(frame: CGRect) {
        super.init(frame: frame)
        setImage(UIImage(named: "navigationbar_arrow_down"), for: .normal)
        setImage(UIImage(named: "navigationbar_arrow_up"), for: .selected)
        setTitleColor(UIColor.black, for: .normal)
        showsTouchWhenHighlighted = true
        sizeToFit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 重新布局文字和图片的位置
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel!.frame.origin.x = 0
        imageView!.frame.origin.x = titleLabel!.frame.size.width + 5
    }

}
