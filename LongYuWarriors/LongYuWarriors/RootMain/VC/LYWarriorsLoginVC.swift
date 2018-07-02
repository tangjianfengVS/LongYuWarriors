//
//  LYWarriorsLoginVC.swift
//  LongYuWarriors
//
//  Created by 汤建锋 on 2018/7/1.
//  Copyright © 2018年 AllOverTheSkyStar. All rights reserved.
//

import UIKit

class LYWarriorsLoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func clickLoginGame(_ sender: UIButton) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: LYWarriorsLoginRootNotif), object: LYWarriorsRootMainVC(), userInfo: nil)
        //dismiss(animated: false, completion: nil)
    }
    
    deinit {
        print("Login释放")
    }
}
