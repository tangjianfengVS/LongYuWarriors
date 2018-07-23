//
//  LYWarriorsChoosegRoleVM.swift
//  LongYuWarriors
//
//  Created by 汤建锋 on 2018/7/7.
//  Copyright © 2018年 AllOverTheSkyStar. All rights reserved.
//

import UIKit
import MBProgressHUD

class LYWarriorsChoosegRoleVM: NSObject {
    let roleNI = LYWarriorsChoosegRoleNI()
    private(set) var roleInterfaceList: [LYWarriorsRoleInterface]=[]
    
    
    func searchRoleInterface() {
       roleInterfaceList = LYWarriorsFMDBManager.shared.loadRoleInterface()
    }
    
    //角色名
    func createName(roleName: String,clousre: (Bool)->()) {
        clousre(true)
    }
    
    //创建角色
    func createRole(name: String?, professionalType: LYWarriorsProfessionalType, clousre: (Bool)->()) {
        if name == nil {
            
        }
        let role = LYWarriorsRoleInterface(names: name!, grades: 1, ids: "99999999", professionalTypes: .grapplePerson)
        LYWarriorsFMDBManager.shared.saveRoleInterface(roleInterface: role)
        clousre(true)
    }
}
