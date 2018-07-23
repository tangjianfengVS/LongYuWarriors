//
//  LYWarriorsCreatRoleNameVI.swift
//  LongYuWarriors
//
//  Created by 汤建锋 on 2018/7/20.
//  Copyright © 2018年 AllOverTheSkyStar. All rights reserved.
//

import UIKit

enum CreatRoleNameType {
    case verifyType
    case cancelType
    case searchType
}

class LYWarriorsCreatRoleNameVI: UIView {
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var verifyBtn: UIButton!
    var clousre: ((CreatRoleNameType)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameText.returnKeyType = .done
        nameText.delegate = self
    }
    
    @IBAction func clickSearchName(_ sender: UIButton) {
        if clousre != nil {
            clousre!(.searchType)
        }
    }
    
    @IBAction func clickVerifyBtn(_ sender: UIButton) {
        if clousre != nil {
            clousre!(.verifyType)
        }
    }
    
    @IBAction func clickCancelBtn(_ sender: UIButton) {
        if clousre != nil {
            clousre!(.cancelType)
        }
    }
}

extension LYWarriorsCreatRoleNameVI: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "\n" {
            textField.endEditing(true)
            return false
        }
        return true
    }
}
