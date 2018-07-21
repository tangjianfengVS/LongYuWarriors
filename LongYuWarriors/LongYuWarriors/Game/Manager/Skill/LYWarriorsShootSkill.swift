//
//  LYWarriorsShootSkill.swift
//  LongYuWarriors
//
//  Created by 汤建锋 on 2018/7/13.
//  Copyright © 2018年 AllOverTheSkyStar. All rights reserved.
//

import SpriteKit
/*
 *   远程直线射击技能
 */
class LYWarriorsShootSkill: SKSpriteNode {
    let roleLYW: LYWarriorsRole!
    let toSpaceCenterSize: CGFloat!
    
    init(role: LYWarriorsRole) {
        roleLYW = role
        let texture = SKTexture(imageNamed: "skill_0001")
        let size = CGSize(width: 150, height: 150)
        let offsetY = role.position.y + role.size.height/2 + size.height/2
        toSpaceCenterSize = offsetY
        super.init(texture: texture, color: UIColor.blue, size: size)
        position = CGPoint(x: role.position.x, y: offsetY)
        
        let center = CGPoint(x: (role.physicsBodyCenter?.x)!, y: 0)
        physicsBody = SKPhysicsBody(rectangleOf: size, center: center)
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
