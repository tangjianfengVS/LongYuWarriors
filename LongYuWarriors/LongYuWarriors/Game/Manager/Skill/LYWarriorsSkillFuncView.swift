//
//  LYWarriorsSkillFuncView.swift
//  LongYuWarriors
//
//  Created by 汤建锋 on 2018/6/10.
//  Copyright © 2018年 AllOverTheSkyStar. All rights reserved.
//

import UIKit

class LYWarriorsSkillFuncView: UIView {
    @IBOutlet weak var stackView: UIStackView!
    var clouse: ((LYWarriorsSkillFunc)->())?
    
    static let shared: LYWarriorsSkillFuncView = {
        let view = UINib.init(nibName: "LYWarriorsSkillFuncView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! LYWarriorsSkillFuncView
        view.backgroundColor = UIColor.clear
        
        if let btn = view.stackView.subviews.first as? LYWarriorsSkillButton{
            btn.skillFunc = .A
        }
        return view
    }()
    
    @IBAction func clickSkillFuncBtn(_ sender: LYWarriorsSkillButton) {
        if clouse != nil {
            clouse!(sender.skillFunc)
        }
    }
}
