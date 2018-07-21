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
                backgroundColor = UIColor.white
            }else{
                showRoleView.image = UIImage(named: professionalType!.rawValue)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        backgroundColor = UIColor.white
        showRoleView.layer.cornerRadius = 5
        showRoleView.layer.masksToBounds = true
        
        showRoleView.layer.borderColor = UIColor.blue.cgColor
        showRoleView.layer.borderWidth = 2
    }

}
