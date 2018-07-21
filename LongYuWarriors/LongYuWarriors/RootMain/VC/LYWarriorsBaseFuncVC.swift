//
//  LYWarriorsBaseFuncVC.swift
//  LongYuWarriors
//
//  Created by 汤建锋 on 2018/7/20.
//  Copyright © 2018年 AllOverTheSkyStar. All rights reserved.
//

import UIKit

class LYWarriorsBaseFuncVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        /*
         * 1.UIDeviceOrientation
         * 表示:设备方向设备的物理方向 作用:获取Home键所在的方向
         */
        /*
         * 2.UIInterfaceOrientation
         * 表示:是你程序界面的当前旋转方向(UIApplication的旋转方向) 作用: 设置UIApplication的旋转方向
         */
        //UIApplication.shared.statusBarOrientation = .landscapeLeft
        /*
         * 3.UIDeviceOrientation 与UIInterfaceOrientation 区分注意点
         * (1).UIDeviceOrientation是机器硬件的当前旋转方向 ,这个你只能取值不能设置
         UIInterfaceOrientation是你程序界面的当前旋转方向,这个可以设置
         * (2).当你机器横屏 ,但是你程序界面没有随之横屏时 UIDeviceOrientation 和 UIInterfaceOrientation 的值就不同了
         */
        /*
         *  二.旋转对象    UIApplication 当前的 UIViewConterltor 的 UIVIew
         *  三.代码实现(在关闭旋屏幕的情况下)
         *  (1).实现只旋转窗口
         */
        super.viewWillAppear(animated)
//        UIApplication.shared.statusBarOrientation = .landscapeRight
//        view.transform = CGAffineTransform.init(rotationAngle: -.pi/2)
//        view.bounds = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight)
    }
    
    override var prefersStatusBarHidden: Bool {
        get {
            return true
        }
    }
    
    override var shouldAutorotate: Bool{
        get{
            return true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
