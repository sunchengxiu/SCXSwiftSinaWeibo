//
//  SCXPresentationC.swift
//  swiftWB
//
//  Created by 孙承秀 on 16/11/11.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

import UIKit

class SCXPresentationC: UIPresentationController {

    //MARK:-懒加载
    fileprivate lazy var coverView : UIView = UIView()
    //MARK : - 系统回调函数，控制model出来的view的底层的那个视图的frame就能控制弹出视图的Frame
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        presentedView?.frame = CGRect(x:(UIScreen.main.bounds.size.width - 180)/2, y: 55, width: 180, height: 250)
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGes(tap:)))
        containerView?.addGestureRecognizer(tap)
        //setUpCoverView()
    }
}
extension SCXPresentationC {

    //MARK:-设置蒙版视图
    fileprivate func setUpCoverView()  {
        
        coverView.frame = (containerView?.bounds)!
        coverView.backgroundColor = UIColor(white: 0.8, alpha: 0.5)
        containerView?.insertSubview(coverView, at: 0)
        
        
    }

}
//MARK:-添加点按手势
extension SCXPresentationC {

    @objc fileprivate func tapGes(tap : UITapGestureRecognizer){
    
        
        presentedViewController.dismiss(animated: true, completion: nil)
    
    }

}
