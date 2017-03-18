//
//  SCXMainViewController.swift
//  swiftWB
//
//  Created by 孙承秀 on 16/11/8.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

import UIKit

class SCXMainViewController: UITabBarController {
    // MARK:-懒加载
    fileprivate lazy var composeButton:UIButton = UIButton(imageName: "tabbar_compose_icon_add", seleImageName: "tabbar_compose_icon_add_highlighted", backgroundImageName: "tabbar_compose_button", seleBackgroundImageName: "tabbar_compose_button_highlighted")
    fileprivate lazy var vcArr = [["vc":"SCXhomeTableViewController","ima":"tabbar_home","seleIma":"tabbar_home_highlighted","title":"首页"],
    ["vc":"SCXMessageTableViewController","ima":"tabbar_message_center","seleIma":"tabbar_message_center_highlighted","title":"消息"],
    ["vc":"SCXMessageTableViewController","ima":"tabbar_message_center","seleIma":"tabbar_message_center_highlighted","title":"消息"],
    ["vc":"SCXDiscoverTableViewController","ima":"tabbar_discover","seleIma":"tabbar_discover_highlighted","title":"发现"],
    ["vc":"SCXMeTableViewController","ima":"tabbar_profile","seleIma":"tabbar_profile_highlighted","title":"我"]];

    //MARK:-系统回调方法
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor=UIColor.red
        //设置UI
        setUpTabbarItems()
        setUpComposeButton()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
//MARK:-设置发布按钮
extension SCXMainViewController{
    ///设置发布按钮
    fileprivate func setUpComposeButton(){
        //添加发布按钮到tabbar上面
        tabBar.addSubview(composeButton)
        composeButton.sizeToFit()
        composeButton.center=CGPoint(x: tabBar.center.x, y: tabBar.frame.size.height*0.5)
        composeButton.addTarget(self, action:#selector(composeButtonClick(_:)) , for: .touchUpInside)
    
    }
}

// MARK: - 按钮点击事件
extension SCXMainViewController{
    
    /// 发布按钮点击事件
    ///
    /// - parameter button: 发布按钮
    //事件监听的本质就是发送消息，首先将方法包装成@SEL的形式，然后到方法列表里面去查找，然后根据@SEL找到对应的方法指针，但是在swift中，private声明的方法是不会添加到方法列表里面去的，所以找不到，但是前面如果加上@objc就可以.
    @objc fileprivate func composeButtonClick(_ button:UIButton) {
        SCXLog(meassage: "点击发布按钮了")
    }

}
//MARK:-设置UI
///设置UI
extension SCXMainViewController{
    /// 设置UI
    fileprivate func setUpTabbarItems(){
   /****************************************************************/
        // MARK:-初始化控制器
        for i in 0..<vcArr.count {
            let vcDic=vcArr[i]
            guard let imageName = vcDic["ima"]  else {
                continue
            }
            guard let seleImageName = vcDic["seleIma"]  else {
                continue
            }
            guard let  title = vcDic["title"]  else {
                continue
            }
            guard let vc = vcDic["vc"]  else {
                continue
            }
            var isEnable=true
            if i==2 {
                isEnable=false
            }
           
            addChildViewController(vc , imageName: imageName, seleImage: seleImageName, title: title,isEnable:isEnable)
            
        }
    }
}
//MARK:-添加控制器到tabbar上面
///添加控制器到tabbar上面
extension SCXMainViewController{
    //MARK:-将控制器添加到tabbar
    ///重载系统方法，将控制器加到tabbar上面
    fileprivate func addChildViewController(_ VCName:String,imageName:String,seleImage:String,title:String,isEnable:Bool) {
        //现获取本项目名称，因为swift比较特殊，再用OC的方式是获取不到控制器的，需要拼接
        guard let  bundleName = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
            SCXLog(meassage: "获取控制器名字失败")
            return;
        }
        //获取控制气的名字，然后转化为控制器
        guard let className=NSClassFromString( bundleName+"."+VCName) else{
            SCXLog(meassage: "获取类名失败")
            return;
        }
        //上面获取的类型是anyClass，需要将他转化为控制器类型
        guard let VCType = className as? UIViewController.Type else {
            SCXLog(meassage: "转化成控制器类型失败")
            return;
        }
        //生成控制器
        let VC = VCType.init()
        let navi : SCXBaseNaviViewController = SCXBaseNaviViewController(rootViewController: VC)
        
        addChildViewController(navi)
        guard isEnable==true else {
            VC.tabBarItem.isEnabled=false
            return
        }
        VC.title=title
        VC.tabBarItem.image=UIImage(named: imageName)
        VC.tabBarItem.selectedImage=UIImage(named: seleImage)
        VC.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.black,NSFontAttributeName : UIFont.boldSystemFont(ofSize: 18)]
        
    }
}
