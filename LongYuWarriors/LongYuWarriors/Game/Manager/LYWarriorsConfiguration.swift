//
//  LYWarriorsConfiguration.swift
//  LongYuWarriors
//
//  Created by 汤建锋 on 2018/6/10.
//  Copyright © 2018年 AllOverTheSkyStar. All rights reserved.
//

import Foundation
import UIKit

enum LYWarriorsSkillFunc: String {
    case unKown
    case raiseType="模拟技能A"
}

let AreaList: [String] = ["江苏区","辽宁区","海南区","北京区","上海区"]
let AreaSubList: [String] = ["江苏-区","江苏二区","江苏三区","江苏四区"]
let SpaceOffsetSize = CGSize(width: 10, height: 100)
let LimitWidth: CGFloat = 30        //上边碰撞width

let SpaceOffsetTopSize: CGFloat = 120
let SkillFuncViewHeight = 46
let OpenAngleRotate: Bool = false
let ScreenWidth = UIScreen.main.bounds.width
let ScreenHeight = UIScreen.main.bounds.height


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

