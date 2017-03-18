//
//  WBTableViewCell.swift
//  swiftWB
//
//  Created by 孙承秀 on 16/12/28.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

import UIKit

class WBTableViewCell: UITableViewCell {
    
    /// 头像
    var iconImageView : UIImageView?
    
    /// 名字
    var nameLabel : UILabel?
    
    /// 来源
    var sourceLabel : UILabel?
    
    /// 微博
    var wbtextLabel : UILabel?
    
    /// 底部工具栏View
    var bottomView : UIView?
    
    /// 分享按钮
    var shareButton : UIButton?
    
    /// 评论按钮
    var textButton : UIButton?
    
    /// 赞按钮
    var supportButton : UIButton?
    
    
    
    
    
    
    var model : SCXViewModel?
        {
        didSet{
            self.removeSubView()
            // 配置头像
            self.setUpIconImageView(model: model)
            
            // 配置名字
            self.setUpTitleLabel(model: model)
            
            // 配置用户来源
            self.setUpSourceLabel(model: model)
            
            // 配置微博数据源
            self.setUptextLabel(model: model)
            
            // 设置底部工具栏
            self.setUpBottomBar()
        }
    }
  
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension WBTableViewCell{
    
    /// 移除子视图
    func removeSubView()  {
        iconImageView?.removeFromSuperview()
        nameLabel?.removeFromSuperview()
        sourceLabel?.removeFromSuperview()
        wbtextLabel?.removeFromSuperview()
        bottomView?.removeFromSuperview()
    }
    /// 配置头像
    ///
    /// - Parameter model: 数据源
    func setUpIconImageView(model : SCXViewModel?)  {
        self.iconImageView = UIImageView()
        iconImageView?.backgroundColor = UIColor.white
        self.iconImageView?.sd_setImage(with: model?.profileURL as! URL, placeholderImage:  UIImage(named: "compose_toolbar_picture"))
        self.iconImageView?.layer.cornerRadius = 20
        self.iconImageView?.layer.masksToBounds = true
        
        contentView.addSubview(self.iconImageView!)
        self.iconImageView?.snp_makeConstraints(closure: { (make) in
            make.left.equalTo(contentView.snp_left).offset(5)
            make.top.equalTo(contentView.snp_top).offset(5)
            make.width.equalTo(40)
            make.height.equalTo(40)
        });
    }
    
    /// 配置标题名字label
    ///
    /// - Parameter model: 数据源
    func setUpTitleLabel(model : SCXViewModel?)  {
        nameLabel = UILabel()
        nameLabel?.font = UIFont.systemFont(ofSize: 15)
        
        // 区分会员和普通用户，会员名字为红色
        if (model?.userInfoModel?.user?.mbrank)! > 0  {
            nameLabel?.textColor = UIColor.orange
        }
        else{
            nameLabel?.textColor = UIColor.black
        }
        nameLabel?.textAlignment = .left
        nameLabel?.text = model?.userInfoModel?.user?.screen_name
        contentView.addSubview(self.nameLabel!)
        
        nameLabel?.snp_makeConstraints(closure: { (make) in
            make.top.equalTo((self.iconImageView?.snp_top)!).offset(2)
            make.left.equalTo((iconImageView?.snp_right)!).offset(10)
        })
        
    }
    
    /// 配置来源数据
    ///
    /// - Parameter model: 数据源
    func setUpSourceLabel(model : SCXViewModel?)  {
        sourceLabel = UILabel()
        sourceLabel?.font = UIFont.systemFont(ofSize: 14)
        self.sourceLabel?.textColor = UIColor.lightGray
        sourceLabel?.textAlignment = .left
        sourceLabel?.text = (model?.dateStr)! + "  " + (model?.sourcesStr)!
        contentView.addSubview(self.sourceLabel!)
        
        sourceLabel?.snp_makeConstraints(closure: { (make) in
            make.top.equalTo((self.nameLabel?.snp_bottom)!).offset(2)
            make.left.equalTo((iconImageView?.snp_right)!).offset(10)
        })
    }
    
    /// 配置微博消息Label
    ///
    /// - Parameter model: 数据源
    func setUptextLabel(model : SCXViewModel?)  {
        wbtextLabel = UILabel()
        contentView.addSubview(wbtextLabel!)
        wbtextLabel?.attributedText = model?.wbAttributeText
        wbtextLabel?.numberOfLines = 0
        wbtextLabel?.snp_makeConstraints(closure: { (make) in
            make.top.equalTo((sourceLabel?.snp_bottom)!).offset(5)
            make.width.equalTo(SCREEN_WIDTH - 10)
            make.left.equalTo(contentView.snp_left).offset(5)
            make.right.equalTo(contentView.snp_right).offset(-5)
            make.height.equalTo((model?.wbTextHeiget)!)
        })
        
    }

    /// 配置底部工具栏
    func setUpBottomBar() {
        // 底部工具栏总试图
        bottomView = UIView()
        bottomView?.backgroundColor = UIColor.white
        contentView.addSubview(bottomView!)
        bottomView?.snp_makeConstraints { (make) in
            make.left.equalTo(contentView.snp_left)
            make.top.equalTo((wbtextLabel?.snp_bottom)!).offset(5)
            make.height.equalTo(30)
            make.width.equalTo(SCREEN_WIDTH)
        }
        // 分享按钮
        shareButton = UIButton()
        bottomView?.addSubview(shareButton!)
        let buttonW = SCREEN_WIDTH / 3
        shareButton?.snp_makeConstraints(closure: { (make) in
            make.top.equalTo((bottomView?.snp_top)!)
            make.bottom.equalTo((bottomView?.snp_bottom)!)
            make.width.equalTo(buttonW)
        })
        shareButton?.setImage(UIImage(named: "timeline_icon_retweet"), for: .normal)
        // 评论按钮
        textButton = UIButton()
        bottomView?.addSubview(textButton!)
        textButton?.snp_makeConstraints(closure: { (make) in
            make.top.equalTo((bottomView?.snp_top)!)
            make.bottom.equalTo((bottomView?.snp_bottom)!)
            make.width.equalTo(buttonW)
            make.left.equalTo((shareButton?.snp_right)!)
        })
        textButton?.setImage(UIImage(named: "timeline_icon_comment"), for: .normal)
        // 赞按钮
        supportButton = UIButton()
        bottomView?.addSubview(supportButton!)
        supportButton?.snp_makeConstraints(closure: { (make) in
            make.top.equalTo((bottomView?.snp_top)!)
            make.bottom.equalTo((bottomView?.snp_bottom)!)
            make.width.equalTo(buttonW)
            make.left.equalTo((textButton?.snp_right)!)
        })
        supportButton?.setImage(UIImage(named: "timeline_icon_unlike"), for: .normal)
        // 头部线
        let topLine : UIView = UIView()
        bottomView?.addSubview(topLine)
        topLine.backgroundColor = lineColor
        topLine.snp_makeConstraints { (make) in
            make.top.equalTo((bottomView?.snp_top)!)
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(1)
            
        }
        
        // 尾部线
        let bottomLine : UIView = UIView()
        bottomView?.addSubview(bottomLine)
        bottomLine.backgroundColor = lineColor
        bottomLine.snp_makeConstraints { (make) in
            make.top.equalTo((bottomView?.snp_bottom)!)
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(1)
            
        }
        // 分割线
        let oneLine : UIView = UIView()
        bottomView?.addSubview(oneLine)
        oneLine.backgroundColor = lineColor
        oneLine.snp_makeConstraints { (make) in
            make.top.equalTo((bottomView?.snp_top)!).offset(5)
            make.bottom.equalTo((bottomView?.snp_bottom)!).offset(-5)
            make.width.equalTo(1)
            make.left.equalTo(buttonW)
        }
        
        let twoLine : UIView = UIView()
        bottomView?.addSubview(twoLine)
        twoLine.backgroundColor = lineColor
        twoLine.snp_makeConstraints { (make) in
            make.top.equalTo((bottomView?.snp_top)!).offset(5)
            make.bottom.equalTo((bottomView?.snp_bottom)!).offset(-5)
            make.width.equalTo(1)
            make.left.equalTo(buttonW * 2)
        }
        
        // 最底部的神色图
        let lastView : UIView = UIView()
        bottomView?.addSubview(lastView)
        lastView.backgroundColor = lineColor
        lastView.snp_makeConstraints { (make) in
            make.top.equalTo((bottomView?.snp_bottom)!).offset(0)
            make.height.equalTo(15)
            make.width.equalTo(SCREEN_WIDTH)
        }

        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
