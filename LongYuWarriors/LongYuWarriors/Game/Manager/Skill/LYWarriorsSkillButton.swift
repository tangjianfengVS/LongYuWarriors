//
//  LYWarriorsSkillButton.swift
//  LongYuWarriors
//
//  Created by 汤建锋 on 2018/6/10.
//  Copyright © 2018年 AllOverTheSkyStar. All rights reserved.
//

import UIKit

class LYWarriorsSkillButton: UIButton {
    var skillFunc: LYWarriorsSkillFunc = .unKown{
        didSet{
            if skillFunc == .unKown {
                isEnabled = false
            }else{
                setBackgroundImage(UIImage(named: skillFunc.rawValue), for: .normal)
                isEnabled = true
            }
        }
    }
 
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        isEnabled = false
        circularBead(size: CGSize(width: 4, height: 4), corner: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
