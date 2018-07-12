//
//  LYWarriorsConfiguration.swift
//  LongYuWarriors
//
//  Created by 汤建锋 on 2018/6/10.
//  Copyright © 2018年 AllOverTheSkyStar. All rights reserved.
//

import Foundation
import UIKit

//---------------------Notif--------------------
let LYWarriorsUpdateRootNotif = "LYWarriorsUpdateRootNotification"

enum LYWarriorsSkillFunc: String {
    case unKown
    case raiseType="模拟技能A"
}

let AreaList: [String] = ["龙羽佳苑","星空领域","南海彼岸","京城之地"]
let AreaSubList: [String] = ["江苏-区","江苏二区","江苏三区","江苏四区"]

let SpaceOffsetSize = CGSize(width: 10, height: 100)
let LimitWidth: CGFloat = 30        //上边碰撞width

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

enum LYWarriorsMarginType: Int {
    case masterType = 0//人物
    case marginType = 1//边缘移动
    case topCrashType = 2//上边碰撞
}

enum LYWarriorsPersonFunc {
    case unKown
    case swordmanPerson//剑客
    case assassinPerson//刺客
    case gunnerPerson  //枪手
    case magicPerson   //魔法师
    case grapplePerson //格斗家
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

