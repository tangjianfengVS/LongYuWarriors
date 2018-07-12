//
//  LYWarriorsDuelDetailListVI.swift
//  LongYuWarriors
//
//  Created by 汤建锋 on 2018/7/12.
//  Copyright © 2018年 AllOverTheSkyStar. All rights reserved.
//

import UIKit

class LYWarriorsDuelDetailListVI: UIView {
    @IBOutlet weak var headerLab: UILabel!
    @IBOutlet weak var listView: UITableView!
    @IBOutlet weak var backImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backImageView.backgroundColor = UIColor(white: 0.2, alpha: 0.5)
        backImageView.layer.cornerRadius = 10
        backImageView.layer.masksToBounds = true
        backImageView.layer.borderWidth = 0.8
        backImageView.layer.borderColor = UIColor.white.cgColor
    }
}
