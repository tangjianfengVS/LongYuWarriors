//
//  LYWarriorsDuelDetailFuncVI.swift
//  LongYuWarriors
//
//  Created by 汤建锋 on 2018/7/11.
//  Copyright © 2018年 AllOverTheSkyStar. All rights reserved.
//

import UIKit

class LYWarriorsDuelDetailFuncVI: UIView {
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var beginGameBtn: UIButton!
    
    var clousre: ((LYWarriorsCoreFunc)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backImageView.backgroundColor = UIColor(white: 0.2, alpha: 0.5)
        backImageView.layer.cornerRadius = 10
        backImageView.layer.masksToBounds = true
        backImageView.layer.borderWidth = 0.8
        backImageView.layer.borderColor = UIColor.white.cgColor
        
        beginGameBtn.layer.cornerRadius = 5
        beginGameBtn.layer.masksToBounds = true
        beginGameBtn.layer.borderWidth = 0.8
        beginGameBtn.layer.borderColor = UIColor.white.cgColor
    }
    
    @IBAction func clickGameMateBtn(_ sender: UIButton) {
        if clousre != nil {
            clousre!(.gameMate)
        }
    }
}


class LYWarriorsDuelDetailFuncBtn: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
