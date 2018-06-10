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
        present(LYWarriorsGameSceneVC(), animated: true, completion: nil)
    }
    
    @IBAction func clickBluetoothFuncBtn(_ sender: UIButton) {
        LYWarriorsBluetoothVC.beginSearch(VC: self) {
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    deinit {
        print("释放")
    }
}
