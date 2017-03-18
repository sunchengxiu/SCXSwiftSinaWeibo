//
//  SCXhomeTableViewController.swift
//  swiftWB
//
//  Created by 孙承秀 on 16/11/8.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

import UIKit
import SDWebImage
class SCXhomeTableViewController: SCXBaseTableViewController {

    lazy var titleButton : SCXTitleButton = SCXTitleButton()
    fileprivate lazy var popperView : SCXPopperViewViewController = SCXPopperViewViewController()
    fileprivate lazy var userInfoModelArr : [SCXViewModel] = [SCXViewModel]()
    ///懒加载转场动画，单独封装，并利用闭包，改变下拉按钮的状态
    fileprivate lazy var popAnimation : SCXPopAnimation = SCXPopAnimation {[weak self] (isPresent) -> () in
        self?.titleButton.isSelected = isPresent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       //设置导航栏按钮
        setUpNaviItem()
       
        // 获取用户数据
        SCXSessionManager.shareInstance.getUserInfoFromNetWork { (resultArr, error) in
            if error == nil {
                guard let resultArr = resultArr else {
                
                    return
                }
                for dic  in resultArr {
                    // kvc 赋值
                    let model = SCXUserInfo(dict: dic)
                    let viewModel = SCXViewModel(userInfoModel: model)
                    // 添加到数据源数组中
                    self.userInfoModelArr.append(viewModel)
                    
                }
                self.tableView.separatorStyle = .none
                //  刷新界面
                 self.tableView.reloadData()
            }
        }
     
    }
    

}

// MARK: - 设置导航栏按钮
extension SCXhomeTableViewController {

    /// 导航栏左右按钮
    func setUpNaviItem()  {
        navigationItem.leftBarButtonItem = UIBarButtonItem(nomalImageName: "navigationbar_friendattention", hightImageName: "navigationbar_friendattention_highlighted")
        navigationItem.rightBarButtonItem = UIBarButtonItem(nomalImageName: "navigationbar_pop", hightImageName: "navigationbar_pop_highlighted")
        //titileButton
        titleButton.setTitle("孙承秀新浪微博", for: .normal)
        titleButton.addTarget(self, action: #selector(titleButtonClick(btn:)), for: .touchUpInside)
        navigationItem.titleView = titleButton
    }

}

// MARK: - titleButton点击事件 
extension SCXhomeTableViewController {
    @objc fileprivate func titleButtonClick (btn : SCXTitleButton){
        btn.isSelected = !btn.isSelected
        // 弹出下拉视图
        popperView.view.backgroundColor = UIColor.clear
        //设置成这种样式，那么，弹出它之后，他下面的视图，不会被系统清空，依然存在
        popperView.modalPresentationStyle = .custom
        //自定义弹出动画
        //自定义模态弹出视图
        popperView.transitioningDelegate = popAnimation
        present(popperView, animated: true, completion: nil)
    
    }
}

// MARK: - tableView 代理方法
extension SCXhomeTableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return userInfoModelArr.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "cellId"
        var cell : WBTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellID) as? WBTableViewCell
        if cell == nil {
            cell = WBTableViewCell(style: .default, reuseIdentifier: cellID)
        }
        let  model = userInfoModelArr[indexPath.row]
        cell?.model = model
       cell?.backgroundColor = UIColor.clear
//        cell?.textLabel?.text = model.dateStr
//        cell?.imageView?.sd_setImage(with: model.profileURL as! URL, placeholderImage: UIImage(named: "compose_toolbar_picture"))
        return cell!
    
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = userInfoModelArr[indexPath.row]
        
        return model.wbTextHeiget! + 60 + 40
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}






