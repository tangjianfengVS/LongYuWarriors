//
//  LYWarriorsHomeDetailVM.swift
//  LongYuWarriors
//
//  Created by 汤建锋 on 2018/7/22.
//  Copyright © 2018年 AllOverTheSkyStar. All rights reserved.
//

import UIKit

class LYWarriorsHomeDetailVM: NSObject {
    
    func synchronization(roleInterface: LYWarriorsRoleInterface, clousre: @escaping (Bool)->()) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            
            let res = LYWarriorsRole.shared(dict: ["sss":"sss"])
            if res{
                clousre(true)
            }
        }
    }
}
