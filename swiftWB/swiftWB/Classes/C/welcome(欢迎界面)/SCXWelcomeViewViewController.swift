//
//  SCXWelcomeViewViewController.swift
//  swiftWB
//
//  Created by 孙承秀 on 16/11/27.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

import UIKit
import SDWebImage
class SCXWelcomeViewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        loadWelcomeView()
        // Do any additional setup after loading the view.
    }
    func loadWelcomeView() -> () {
        let imageView = UIImageView(frame: view.bounds)
        view = imageView
        imageView.image = UIImage(named: "ad_background")
        let iconImage = UIImageView(image: UIImage(named: "avatar_default"))
        let urlStr = SCXAccountTool.shareInstance.account?.avatar_large
        let url : URL = NSURL(string: urlStr ?? "") as! URL
        
        iconImage.sd_setImage(with: url, placeholderImage: UIImage(named: "avatar_default"))
        imageView.addSubview(iconImage)
        iconImage.frame = CGRect(x: view.center.x-25, y: view.frame.size.height-250, width: 50, height: 50)
        
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations: {
            iconImage.frame = CGRect(x: self.view.center.x-25, y: 150, width: 50, height: 50)
            //self.view.layoutIfNeeded()
            }) { (_) in
         UIApplication.shared.keyWindow?.rootViewController = SCXMainViewController()
        }
        
    }

}
