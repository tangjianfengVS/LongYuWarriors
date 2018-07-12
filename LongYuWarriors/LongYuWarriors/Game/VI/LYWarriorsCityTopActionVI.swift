//
//  LYWarriorsCityTopActionVI.swift
//  LongYuWarriors
//
//  Created by 汤建锋 on 2018/7/11.
//  Copyright © 2018年 AllOverTheSkyStar. All rights reserved.
//

import UIKit

class LYWarriorsCityTopActionVI: UIView {
    var clousre: ((LYWarriorsCoreFunc)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func clickPKActionBtn(_ sender: UIButton) {
        if clousre != nil {
            clousre!(.duel)
        }
    }
}
