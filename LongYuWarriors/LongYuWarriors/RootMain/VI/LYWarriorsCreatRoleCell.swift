//
//  LYWarriorsCreatRoleCell.swift
//  LongYuWarriors
//
//  Created by 汤建锋 on 2018/7/20.
//  Copyright © 2018年 AllOverTheSkyStar. All rights reserved.
//

import UIKit

class LYWarriorsCreatRoleCell: UICollectionViewCell {
    @IBOutlet weak var showRoleView: UIImageView!
    
    var professionalType: LYWarriorsProfessionalType?{
        didSet{
            if professionalType == nil {
                showRoleView.backgroundColor = UIColor.white
            }else{
                showRoleView.image = UIImage(named: professionalType!.rawValue)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        showRoleView.layer.cornerRadius = 5
        showRoleView.layer.masksToBounds = true
        
        showRoleView.layer.borderColor = UIColor(red: 255/256.0, green: 229/256.0, blue: 213/256.0, alpha: 1).cgColor
        showRoleView.layer.borderWidth = 2
    }

}
