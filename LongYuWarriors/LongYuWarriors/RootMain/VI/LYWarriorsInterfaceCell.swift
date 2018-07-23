//
//  LYWarriorsInterfaceCell.swift
//  LongYuWarriors
//
//  Created by 汤建锋 on 2018/5/20.
//  Copyright © 2018年 AllOverTheSkyStar. All rights reserved.
//

import UIKit

class LYWarriorsInterfaceCell: UICollectionViewCell {
    @IBOutlet weak var gradeLab: UILabel!
    @IBOutlet weak var nameLab: UILabel!
    @IBOutlet weak var classLab: UILabel!
    @IBOutlet weak var roleImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 0.8
    }
    
    var roleInterface: LYWarriorsRoleInterface?{
        didSet{
            gradeLab.text = String.init(format: "%d", (roleInterface?.grade)!)
            nameLab.text = roleInterface?.name
            classLab.text = roleInterface?.professionalType.rawValue
            roleImageView.image = UIImage(named: (roleInterface?.professionalType.rawValue)!)
        }
    }
}
