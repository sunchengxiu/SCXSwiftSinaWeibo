//
//  SCXSessionManager.swift
//  swiftWB
//
//  Created by 孙承秀 on 16/11/12.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

import AFNetworking
// com.360qiyun.pan
//Power.swiftWB
enum netType : String{
case Get = "get"
    case Post = "post"

}
class SCXSessionManager: AFHTTPSessionManager {
    ///单例
    static let shareInstance : SCXSessionManager = {
    
        let manager = SCXSessionManager()
    manager.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json","text/plain", "text/json", "text/javascript", "text/html") as? Set<AnyHashable>
        return manager
    }()
    
}

// MARK: - 基本网络请求方法
extension SCXSessionManager {
    func SCX_Request(requestType : netType , urlString : String , parameters : [String : Any]?,success : @escaping ( (_ resultData : Any? , _ error : Error?) -> ()))  {
        let successBlock = { (task : URLSessionDataTask, result : Any) in
           // SCXLog(meassage: result)
            success(result, nil)
        }
        let fauileBlock = { (task : URLSessionDataTask?, error :Error) in
           success(nil, error)
        }
        switch requestType {
        case .Get  :
            get(urlString, parameters: parameters, success: successBlock, failure: fauileBlock)
        default:
            post(urlString, parameters: parameters, success: successBlock, failure: fauileBlock)
        }
        
        
    }

}

// MARK: - 获取授权的access_token
extension SCXSessionManager {

     func requestForGetAccess_token(access_code : String , finishBlock : @escaping (_ responseDic : [String : AnyObject]? , _ error : Error?) -> ()) {
    
        // 拼接URL
        let urlStr = "https://api.weibo.com/oauth2/access_token"
        let parametres = ["client_id" : APP_KEY , "client_secret" : APP_SCREPT , "grant_type" : "authorization_code" , "code" : access_code , "redirect_uri" : Redirect_Uri]
        SCX_Request(requestType: .Post, urlString: urlStr, parameters: parametres) { (request : Any?, error : Error?) in
            finishBlock(request as? [String : AnyObject], error)
        }
    }

}


// MARK: - 获取用户信息接口,通过access_token
extension SCXSessionManager {

    ///获取用户详细信息
    func getUserInfoUseAccess_token(token : String , uid : String, finishBlock : @escaping (_ dict : [String : AnyObject]? , _ error : Error?) -> ())  {
        
        let urlStr = "https://api.weibo.com/2/users/show.json"
        let parameters = ["access_token" : token , "uid" : uid]
        
        SCX_Request(requestType: .Get, urlString: urlStr, parameters: parameters) { (result : Any?, error : Error?) in
            finishBlock(result as? [String :AnyObject] , error)
        }
        
    }


}


// MARK: - 获取用户数据
extension SCXSessionManager {

    // https://api.weibo.com/2/statuses/home_timeline.json
    func getUserInfoFromNetWork(finishBlock : @escaping (_ result : [[String : AnyObject]]? , _ error : Error?) -> ())  {
        let url = "https://api.weibo.com/2/statuses/home_timeline.json"
        
        let token = SCXAccountTool.shareInstance.account?.access_token
        let parameters = ["access_token" : token]
        
        SCX_Request(requestType: .Get, urlString:url , parameters: parameters) { (result : Any?, error : Error?) in
        
            guard let result = result as? [String : AnyObject]  else {
            
                finishBlock(nil, error)
                return
            }
            guard let resultArr = result["statuses"] as? [[String : AnyObject]]  else {
            
                finishBlock(nil, error)
                return
            }
            finishBlock(resultArr , nil)
            
        }
    }
}
