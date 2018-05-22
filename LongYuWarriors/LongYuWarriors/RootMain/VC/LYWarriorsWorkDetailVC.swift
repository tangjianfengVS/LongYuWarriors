//
//  LYWarriorsWorkDetailVC.swift
//  LongYuWarriors
//
//  Created by 汤建锋 on 2018/5/21.
//  Copyright © 2018年 AllOverTheSkyStar. All rights reserved.
//

import UIKit

class LYWarriorsWorkDetailVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

 
    }
    
    @IBAction func clickBeginGameBtn(_ sender: UIButton) {
        let VC = LYWarriorsGameSceneVC()
        UIApplication.shared.keyWindow?.rootViewController = VC
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
