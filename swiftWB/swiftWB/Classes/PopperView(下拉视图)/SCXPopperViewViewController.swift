//
//  SCXPopperViewViewController.swift
//  swiftWB
//
//  Created by 孙承秀 on 16/11/11.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

import UIKit

class SCXPopperViewViewController: UIViewController {

    var isPresent: Bool = true
    
    //MARK:-懒加载
    fileprivate lazy var backgroundImageView : UIImageView = UIImageView()
    fileprivate lazy var tableView : UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UI
        setUpBackgroundImageView()
        setUpTableView()
    }

}

// MARK: - UI设置
extension SCXPopperViewViewController {

    //MARK:-设置背景图片
    fileprivate func setUpBackgroundImageView()  {
        backgroundImageView.frame = CGRect(x: 0, y: 0, width: 180, height: 250)
        backgroundImageView.image = UIImage(named: "popover_background")
        view.addSubview(backgroundImageView)
    }
    
    //MARK:-设置tableView表格
    fileprivate func setUpTableView(){
        view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.left.equalTo(backgroundImageView.snp_left).offset(10)
            make.top.equalTo(backgroundImageView.snp_top).offset(15)
        make.right.equalTo(backgroundImageView.snp_right).offset(-10)
            make.bottom.equalTo(backgroundImageView.snp_bottom).offset(-10)
            
        }
    }
}


