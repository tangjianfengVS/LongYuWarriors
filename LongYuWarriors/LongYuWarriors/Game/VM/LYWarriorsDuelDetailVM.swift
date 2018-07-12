//
//  LYWarriorsDuelDetailVM.swift
//  LongYuWarriors
//
//  Created by 汤建锋 on 2018/7/11.
//  Copyright © 2018年 AllOverTheSkyStar. All rights reserved.
//

import UIKit

class LYWarriorsDuelDetailVM: NSObject {

    func search(type: LYWarriorsCoreFunc, clousre: (Bool,LYWarriorsRole?)->()) {
        
        clousre(true,LYWarriorsRole(texture: nil, color: UIColor.cyan, size: CGSize.zero))
    }
}
