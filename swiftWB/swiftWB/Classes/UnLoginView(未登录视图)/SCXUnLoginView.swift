//
//  SCXUnLoginView.swift
//  swiftWB
//
//  Created by 孙承秀 on 16/11/9.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

import UIKit
import SnapKit

class SCXUnLoginView: UIView {
    
    convenience init(isHidden:Bool) {
        self.init()
        
        // 设置UI
        setUpRoteView(isHidden)
        setUpHomeView()
        setUpLabel()
        setUpButton()
    }
    //MARK:-懒加载
    /// 懒加载
    fileprivate lazy var imageView : UIView = UIImageView()
    fileprivate lazy var homeImageView : UIImageView = UIImageView()
    fileprivate lazy var tipLabel : UILabel = UILabel()
    lazy var registerButton : UIButton = UIButton()
    lazy var loginButton : UIButton = UIButton()
    fileprivate lazy var vistorView : UIImageView = UIImageView()
}

// MARK: - 公共方法，每个界面对应不同的logo
extension SCXUnLoginView {
    func setUpLogo(imageName : String , isHiddenImageView : Bool, title : String)  {
        imageView.isHidden = isHiddenImageView
        homeImageView.contentMode = .center
        homeImageView.image = UIImage(named: imageName)
        tipLabel.text = title
    }
}

// MARK: - UI设置
extension SCXUnLoginView{
    //MARK:-设置旋转那个图片
    /// 设置旋转那个图片
    ///
    /// - parameter isHidden: 是否隐藏
    fileprivate func setUpRoteView(_ isHidden:Bool){
        imageView = UIImageView(image: UIImage(named:"visitordiscover_feed_image_smallicon"), highlightedImage: UIImage(named:""))
        SCXLog(meassage: imageView.frame.size.width)
        
        imageView.frame=CGRect(x:( UIScreen.main.bounds.size.width-(imageView.frame.size.width))/2, y: 200, width: 175, height: 175)
        imageView.isHidden=isHidden
        let basicAni = CABasicAnimation(keyPath: "transform.rotation.z")
        basicAni.fromValue = 0
        basicAni.toValue = M_PI * 2
        basicAni.isRemovedOnCompletion = false
        basicAni.duration = 5
        basicAni.repeatCount = MAXFLOAT
        imageView.layer.add(basicAni, forKey: "")
        addSubview(imageView)
        /// 遮挡视图
        vistorView.image=UIImage(named: "visitordiscover_feed_mask_smallicon")
        addSubview(vistorView)
        vistorView.snp_makeConstraints { (make) in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.top.equalTo(imageView.snp_top).offset(-5)
            
        }
        
        
    }
    
    
    //MARK:-设置home那个图片
    /// 设置home那个图片
    fileprivate func setUpHomeView(){
        homeImageView = UIImageView(image: UIImage(named:"visitordiscover_feed_image_house"), highlightedImage: UIImage(named:""))
        SCXLog(meassage: imageView.frame.size.width)
        
        homeImageView.frame=CGRect(x:( UIScreen.main.bounds.size.width-(homeImageView.frame.size.width))/2, y: 270, width: 90, height: 94)
        homeImageView.isHidden=isHidden
        addSubview(homeImageView)
    }
    
    
    //MARK:-设置提示label
    /// 设置提示label
    fileprivate func setUpLabel(){
        tipLabel.numberOfLines=0
        tipLabel.font=UIFont.systemFont(ofSize: 15)
        tipLabel.textColor = UIColor.lightGray
        tipLabel.text="关注一些人，回这里看看有什么惊喜"
        tipLabel.textAlignment = .center
        addSubview(tipLabel)
        tipLabel.snp_makeConstraints { (make) in
            make.top.equalTo(homeImageView.snp_bottom).offset(50)
            make.left.equalTo(imageView.snp_left).offset(-50)
            make.right.equalTo(imageView.snp_right).offset(50)
        }
        
        
    }
    
    /// 设置登录注册按钮
    fileprivate func setUpButton(){
        registerButton.setTitle("注册", for: .normal)
        registerButton.setTitleColor(UIColor.orange, for: .normal)
        loginButton.setTitle("登陆", for: .normal)
        loginButton.setTitleColor(UIColor.lightGray, for: .normal)
        registerButton.setBackgroundImage(UIImage(named:"common_button_white_disable"), for: .normal)
        loginButton.setBackgroundImage(UIImage(named:"common_button_white_disable"), for: .normal)
        
        addSubview(registerButton)
        addSubview(loginButton)
        registerButton.snp_makeConstraints { (make) in
            make.left.equalTo(tipLabel.snp_left)
            make.width.equalTo(100)
            make.top.equalTo(tipLabel.snp_bottom).offset(50)
            make.height.equalTo(40)
        }
        loginButton.snp_makeConstraints { (make) in
            make.right.equalTo(tipLabel.snp_right)
            make.width.equalTo(100)
            make.top.equalTo(tipLabel.snp_bottom).offset(50)
            make.height.equalTo(40)
        }
        
    }
}

