//
//  LYWarriorsDrawingChopSkill.swift
//  LongYuWarriors
//
//  Created by 汤建锋 on 2018/7/19.
//  Copyright © 2018年 AllOverTheSkyStar. All rights reserved.
//

import SpriteKit

class LYWarriorsDrawingChopSkill: LYWarriorsSkill {
    init(role: LYWarriorsRole) {
        let texture = SKTexture(imageNamed: "模拟技能A")
        super.init(role: role, texture: texture, color: UIColor.blue, size: OutrangebrakeSkillSize)
        position = role.position
        let path = CGPath(ellipseIn: CGRect(x: -OutrangebrakeSkillSize.width/2,
                                            y: -OutrangebrakeSkillSize.height/2,
                                            width: OutrangebrakeSkillSize.width,
                                            height: OutrangebrakeSkillSize.height), transform: nil)
        physicsBody = SKPhysicsBody(edgeLoopFrom: path)
        physicsBody?.isDynamic = false
        physicsBody?.categoryBitMask = LYWarriorsMarginType.ATKScopeType.rawValue
        
        var bitMask = LYWarriorsMarginType.masterType.rawValue
        if role.physicsBody?.categoryBitMask == bitMask {
            bitMask = LYWarriorsMarginType.defierType.rawValue
        }
        physicsBody?.contactTestBitMask = bitMask
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
