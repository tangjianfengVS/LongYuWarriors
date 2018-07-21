//
//  LYWarriorsActionView.swift
//  LongYuWarriors
//
//  Created by 汤建锋 on 2018/7/7.
//  Copyright © 2018年 AllOverTheSkyStar. All rights reserved.
//

import UIKit

enum ActionActionType {
    case creatRoleType
    case beginGameType
}

class LYWarriorsActionView: UIView {
    var clouse: ((ActionActionType)->())?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func clickCreatRoleBtn(_ sender: UIButton) {
        if clouse != nil {
            clouse!(.creatRoleType)
        }
    }
    
    @IBAction func clickBeginGame(_ sender: UIButton) {
        if clouse != nil {
            clouse!(.beginGameType)
        }
    }
}
