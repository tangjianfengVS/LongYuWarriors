//
//  LYWarriorsProtocol.swift
//  LongYuWarriors
//
//  Created by 汤建锋 on 2018/7/10.
//  Copyright © 2018年 AllOverTheSkyStar. All rights reserved.
//

import UIKit

protocol SafeLayoutProtocol {}

protocol LYWarriorsJoystickProtocol {
    func joystickBegan(Joystick: LYWarriorsJoystick,touches: Set<UITouch>,event: UIEvent);
    func joystickMoved(Joystick: LYWarriorsJoystick,touches: Set<UITouch>,event: UIEvent);
    func joystickEnded(Joystick: LYWarriorsJoystick,touches: Set<UITouch>,event: UIEvent);
    func joystickCanceled(Joystick: LYWarriorsJoystick,touches: Set<UITouch>,event: UIEvent);
}

extension SafeLayoutProtocol {
    func safeLayoutSize(top: NSLayoutConstraint,bottom: NSLayoutConstraint){
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            top.constant = -appDelegate.safeSize.width
            bottom.constant = -appDelegate.safeSize.height
        }
    }
    
    func safeLayoutGaugeSize()-> (CGFloat,CGFloat){
        var topSize: CGFloat = 0
        var bottomSize: CGFloat = 0
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            if appDelegate.safeSize.width > 20{
                topSize = appDelegate.safeSize.width
                bottomSize = appDelegate.safeSize.height
            }
        }
        return (topSize,bottomSize)
    }
    
    func reighstCurrentVC(VC: UIViewController){
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            appDelegate.currentVC = VC
        }
    }
    
    func interfaceOrientations(type: ScreenRotationType){
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            appDelegate.allowRotation = type
        }
    }
}
