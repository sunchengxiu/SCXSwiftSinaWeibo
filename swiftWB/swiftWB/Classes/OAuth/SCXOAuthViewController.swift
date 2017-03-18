//
//  SCXOAuthViewController.swift
//  swiftWB
//
//  Created by 孙承秀 on 16/11/20.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

import UIKit
import SVProgressHUD
class SCXOAuthViewController: UIViewController {
    /// 懒加载
    fileprivate lazy var webView = UIWebView(frame: UIScreen.main.bounds)
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        title = "授权登录"
        // 界面设置
        setUpNaviButton()
        setUpWebView()
    }


}

// MARK: - 懒加载
extension SCXOAuthViewController {
   
}

// MARK: - 关闭按钮和填充按钮设置
extension SCXOAuthViewController{
    fileprivate func setUpNaviButton () {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(dismissButtonClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "填充", style: .plain, target: self, action: #selector(fillButtonClick))
    }

}

// MARK: - 设置webview
extension SCXOAuthViewController{
    fileprivate func setUpWebView () {
        view.addSubview(webView)
        // 示例 https://api.weibo.com/oauth2/authorize?client_id=123050457758183&redirect_uri=http://www.example.com/response&response_type=code
        let url = "https://api.weibo.com/oauth2/authorize?client_id=\(APP_KEY)&redirect_uri=\(Redirect_Uri)"
        let URL  = NSURL(string: url)
        webView.delegate = self
        webView.loadRequest(NSURLRequest(url: URL as! URL  ) as URLRequest)
    }
}

// MARK: - 按钮点击事件
extension SCXOAuthViewController {
    // 关闭按钮点击事件
    @objc fileprivate func dismissButtonClick () {
        navigationController?.dismiss(animated: true, completion: nil)
    
    }
    // 填充按钮点击事件
    @objc fileprivate func fillButtonClick () {
        SCXLog(meassage: "点击填充按钮了")
        // 植入JS代码，填充用户名和密码
        let js = "document.getElementById('userId').value='\(user)';document.getElementById('passwd').value='\(passwd)';"
        webView.stringByEvaluatingJavaScript(from: js)
        
    }

}

// MARK: - webview代理方法
extension SCXOAuthViewController : UIWebViewDelegate {

    
    /// 开始加载webview
    ///
    /// - parameter webView: webview
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
    }
    
    /// 结束加载webview
    ///
    /// - parameter webView: webview
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    
    /// 加载失败
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        SVProgressHUD.dismiss()
    }
    
    
    /// 加载一个url都会调用此方法，此方法会限定一些url是否需要显示
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        // 允许加载
        guard let url = request.url else {
            return true;
        }
        let urlString = url.absoluteString
        
        guard (urlString.contains("code=")) else {
            return true
        }
        let code = urlString.components(separatedBy: "code=").last!
        print("access_code=\(code)")
        self.getAccess_tokenUseAccessCode(code: code)
        // 不允许加载
        return false;
    }

}

// MARK: - 获取access_token
extension SCXOAuthViewController {
    
    /// 获取access_token
    ///
    /// - parameter code: access_code
    fileprivate func getAccess_tokenUseAccessCode(code : String) {
    
        SCXSessionManager.shareInstance.requestForGetAccess_token(access_code: code) { (result : [String : AnyObject]?, error : Error?) in
        
            if error != nil{
            
                SCXLog(meassage: error)
                return
            }
            /*
             ["expires_in": 157679999, "remind_in": 157679999, "access_token": 2.00b6KhVCplovjB4fde56858ea54WgE, "uid": 2300620211]
             */
            guard result != nil else {
            
                return;
            }
            let accessModel = SCXAccessModel(dict: result!)
        
            guard accessModel.access_token != nil else {
                return
            }
            self.getUserInfoUseToken(token : accessModel.access_token! , uid : accessModel.uid! , account:  accessModel)
        }
        
    }
    
}

// MARK: - 获取用户信息
extension SCXOAuthViewController {

    func getUserInfoUseToken(token : String , uid : String , account : SCXAccessModel)  {
        
        /// 通过网路请求获取用户信息
        SCXSessionManager.shareInstance.getUserInfoUseAccess_token(token: token , uid : uid) { (responseObject, error) in
            if error != nil {
            
                return
            }
            let dict = responseObject
            account.screen_name = dict?["screen_name"] as? String
            account.avatar_large = dict?["avatar_large"] as? String
            /// 归档
            NSKeyedArchiver.archiveRootObject(account, toFile: SCXAccountTool.shareInstance.accountPath)
            
            // 即时更新单例中保存的对象，要不然单例会一直维持之前的对象
            SCXAccountTool.shareInstance.account = account
           self.navigationController?.dismiss(animated: false, completion: {
                // 弹出访客视图
                UIApplication.shared.keyWindow?.rootViewController = SCXWelcomeViewViewController()
            })
            
        }
    }

}
