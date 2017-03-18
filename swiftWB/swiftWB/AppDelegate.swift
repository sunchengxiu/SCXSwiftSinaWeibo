//
//  AppDelegate.swift
//  swiftWB
//
//  Created by 孙承秀 on 16/11/8.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var defaultVC : UIViewController {
    
        let islogin = SCXAccountTool.shareInstance.isLogin
        return islogin ? SCXWelcomeViewViewController() :SCXMainViewController() 
    
    }
    public let Screen_Weight = UIScreen.main.bounds.size.width
    let Screen_Height = UIScreen.main.bounds.size.height
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window=UIWindow(frame: UIScreen.main.bounds)
        let mainVC=SCXMainViewController()
      
        window?.rootViewController=defaultVC;
        UITabBar.appearance().tintColor=UIColor.orange
        UINavigationBar.appearance().tintColor = UIColor.orange
        window?.makeKeyAndVisible()
        
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //测试AFN网络工具
        SCXSessionManager.shareInstance.SCX_Request(requestType: .Get, urlString: "http://httpbin.org/get", parameters: ["name" : "SCX" , "age" : "18"]) { (responseDate, error) in
            if error != nil {
                
                SCXLog(meassage: error)
            }
            else{
                
                SCXLog(meassage: responseDate)
            }
        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}
// MARK: - 自定义打印方法
func SCXLog<Type>(file:String=#file,funcName:String=#function,line:Int=#line,meassage:Type) {
    
    #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        
        print("\(fileName):\(funcName):\(line)****\(meassage)")
        
    #endif
}
