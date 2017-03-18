//
//  SCXBaseTableViewController.swift
//  swiftWB
//
//  Created by 孙承秀 on 16/11/8.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

import UIKit

class SCXBaseTableViewController: UITableViewController {
    lazy var unLoginview : SCXUnLoginView = SCXUnLoginView(isHidden: false)
    var isLogin = false;
/****************************************************************/
    //判断登陆或者未登录，要切换的视图
    override func loadView() {
        SCXLog(meassage: SCXAccountTool.shareInstance.accountPath)
        isLogin = SCXAccountTool.shareInstance.isLogin
        isLogin ? super.loadView() : setUpUnLoadView()
    }
    
    /// 访客视图
    func setUpUnLoadView()  {
        unLoginview.backgroundColor=UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        view=unLoginview
        //注册，登陆按钮点击事件
        unLoginview.registerButton.addTarget(self, action: #selector(registerButtonClick), for: .touchUpInside)
        unLoginview.loginButton.addTarget(self, action: #selector(loginButtonClick), for: .touchUpInside)
        
    }
/****************************************************************/
    override func viewDidLoad() {
        super.viewDidLoad()
       //设置导航栏登陆注册按钮
       setUpNavigationItems()
    }
}

// MARK: - 设置导航栏按钮
extension SCXBaseTableViewController {
    fileprivate func setUpNavigationItems(){
        navigationItem.leftBarButtonItem=UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(registerButtonClick))
        navigationItem.rightBarButtonItem=UIBarButtonItem(title: "登录", style: .plain, target: self, action: #selector(loginButtonClick))
   
    }

}

// MARK: - 按钮点击事件
extension SCXBaseTableViewController {

    //注册按钮点击事件
    func registerButtonClick()  {
        SCXLog(meassage: "点击注册了")
    }
    
    // 登陆按钮点击事件
    func loginButtonClick()  {
        SCXLog(meassage: "点击登陆了")
        let OAuthVC = SCXOAuthViewController()
        let nav = UINavigationController(rootViewController: OAuthVC)
        present(nav, animated: true, completion: nil)
        
        
    }

}
