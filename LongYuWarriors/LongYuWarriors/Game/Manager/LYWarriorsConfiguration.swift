//
//  LYWarriorsConfiguration.swift
//  LongYuWarriors
//
//  Created by 汤建锋 on 2018/6/10.
//  Copyright © 2018年 AllOverTheSkyStar. All rights reserved.
//

import Foundation
import UIKit

let Current_Mode = Test
let Test: Int = 0
let Default: Int = 1

enum ScreenRotationType: Int {
    case left
    case right
    case all
    case portrait//初次受力
}

//---------------------Notif--------------------
let LYWarriorsUpdateRootNotif = "LYWarriorsUpdateRootNotification"
let InterfaceOrientationUpdateMask = "InterfaceOrientationUpdateMask"

enum LYWarriorsSkillFunc: String {
    case unKown
    case raiseType="模拟技能A"
    case raiseBType="升龙击"
    case raiseCType="冲击波"
    case raiseDType="陨石坠落"
    case raiseEType="崩山击"
    case raiseFType="拔刀斩"
    case raiseHType="普通攻击"
}

let AreaList: [String] = ["龙羽佳苑","星空领域","南海彼岸","京城之地"]
let AreaSubList: [String] = ["江苏-区","江苏二区","江苏三区","江苏四区"]

let SpaceOffsetSize = CGSize(width: 10, height: 100)
//let LimitWidth: CGFloat = 30        //上边碰撞width

let SpaceOffsetTopSize: CGFloat = 120
let SkillFuncViewHeight = 46
let OpenAngleRotate: Bool = false
let ScreenWidth = UIScreen.main.bounds.width
let ScreenHeight = UIScreen.main.bounds.height

//-----------City--------------------
let CitMoveSpeed: CGFloat = 100
let CitMoveTime: TimeInterval = 0.1

//------------PK-----------------
let DuelDetailListWidth: CGFloat = 270
let DuelDetailWidth: CGFloat = 158
let DuelDetailHeight: CGFloat = 355

//--------------人物移动范围,人物攻击范围-----------------
let RolePhysicsBodySize = CGSize(width: 30, height: 70)//x,y
//--------------人物攻击范围------------------
//let RoleATKPhysicsSize = CGSize(width: 30, height: 70)//x,y

//--------------浮空技能宽度范围---------------
let LevitateSkillWidth: CGFloat = 12
//------------------------------------------
let OutrangebrakeSkillSize: CGSize=CGSize(width: 100, height: 160)


enum LYWarriorsCoreFunc: String {
    case storage="物品"
    case property="属性"
    case skill="技能"
    case friend="好友"
    case duel="对决"
    case shopping="商城"
    case setting="设置"
    case gameMate="自动匹配"
}

enum LYWarriorsAreaServiceType {
    case A
    case B
}

enum LYWarriorsPersonClass: Int {
    case masterClass = 0
    case defierClass = 1
}

enum LYWarriorsMarginType: UInt32 {
    case masterType = 1//
    case defierType = 2//挑战者
    case marginType = 3//边缘移动
    //case topCrashType = 4//上边碰撞
    case ATKScopeType=4//攻击力范围
    case ATKAcceptType=5//受攻击力范围
}

enum LYWarriorsProfessionalType: String {
    case grapplePerson="格斗者"
    case swordmanPerson="刀剑客"
    case gunnerPerson="枪炮专家"
//    case assassinPerson//刺客
//    case gunnerPerson  //枪手
//    case magicPerson   //魔法师
    
    static var allValues: [LYWarriorsProfessionalType] {
        return [.grapplePerson, .swordmanPerson, .gunnerPerson]
    }
}


//1: 移动
//2: 移动范围限制
//3: 移动方向判定
//4: 


/*
 *    1.剑客- 长剑
 */

/*
 *    2.刺客- 双短剑
 */

/*
 *    3.魔法师- 法杖
 */

/*
 *    4.枪手- 枪炮
 */

/*
 *    5.格斗家- 护甲
 */

