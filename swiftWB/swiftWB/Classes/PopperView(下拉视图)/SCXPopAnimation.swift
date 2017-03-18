//
//  SCXPopAnimation.swift
//  swiftWB
//
//  Created by 孙承秀 on 16/11/11.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

import UIKit

class SCXPopAnimation: NSObject {
    var isPresent: Bool = true
    ///按钮点击回调，将按钮的状态对应下拉视图的状态
    var  callBack : ( (_ isPresented : Bool ) -> () )?
    override init() {
        
    }
    ///构造函数
    init(callBack :  ((_ isPresented : Bool) -> ())? ) {
        self.callBack = callBack
    }
    
}
//MARK:-自定义转场Frame，通过UIPresentationController代理方法，设置弹出的大小和动画
extension SCXPopAnimation : UIViewControllerTransitioningDelegate {
    
    //MARK : -  自定义转场的方法
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return SCXPresentationC(presentedViewController: presented, presenting: presenting)
    }
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresent = true
        callBack!(isPresent)
        return self
    }
    
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresent = false
        callBack!(isPresent)
        return self
    }
    
}
//MARK:-自定义转场动画
extension SCXPopAnimation : UIViewControllerAnimatedTransitioning {
    ///设置转场动画的时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    //获取转场上下文，通过上下文来获取弹出的View和消失的View
    //UITransitionContextViewKey.to 获取弹出的View
    //UITransitionContextViewKey.from 获取小时的View
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        //animationForPresentedView(transitionContext)
        if isPresent {
            animationForPresentedView(transitionContext)
        }
        if !isPresent {
            animationForDismissedView(transitionContext: transitionContext)
        }
        
    }
    fileprivate func animationForPresentedView(_ transitionContext: UIViewControllerContextTransitioning) {
        let presentView = transitionContext.view(forKey: UITransitionContextViewKey.to)
        if presentView != nil {
            presentView?.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
            transitionContext.containerView.addSubview(presentView!)
            //执行动画
            presentView?.transform = CGAffineTransform.init(scaleX: 1.0, y: 0.0)
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                presentView?.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            }) { (isFinished) in
                //告诉动画结束了
                transitionContext.completeTransition(true)
            }
            
            
        }
        
    }
    
    
    /// 自定义消失动画
    fileprivate func animationForDismissedView(transitionContext: UIViewControllerContextTransitioning) {
        let presentView = transitionContext.view(forKey: UITransitionContextViewKey.from)
        //执行动画
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            presentView?.transform = CGAffineTransform.init(scaleX: 1.0, y: 0.01)
        }) { (isFinished) in
            presentView?.removeFromSuperview()
            //告诉动画结束了
            transitionContext.completeTransition(true)
        }
    }
    
    
}



