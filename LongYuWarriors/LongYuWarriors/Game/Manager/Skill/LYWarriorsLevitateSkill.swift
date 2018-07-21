//
//  LYWarriorsLevitateSkill.swift
//  LongYuWarriors
//
//  Created by 汤建锋 on 2018/7/15.
//  Copyright © 2018年 AllOverTheSkyStar. All rights reserved.
//

import SpriteKit


//class LYWarriorsSkillBody: SKPhysicsBody{
//    var roleLYW: LYWarriorsRole!
//
//    class func skillBody(rectangleOf: CGSize, center: CGPoint) -> LYWarriorsSkillBody{
//        let body = LYWarriorsSkillBody(rectangleOf: rectangleOf, center: center)
//        //body.roleLYW =
//        return body
//    }
//    init(rectangleOf: CGSize, center: CGPoint) {
//        super.init
//
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}

class LYWarriorsSkill: SKSpriteNode{
    let roleLYW: LYWarriorsRole!
    
    init(role: LYWarriorsRole,texture: SKTexture, color: UIColor, size: CGSize) {
        roleLYW = role
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/*
 *   近身浮空技能
 */
class LYWarriorsLevitateSkill: LYWarriorsSkill {
    
    init(role: LYWarriorsRole) {
        let texture = SKTexture(imageNamed: "模拟技能A")
        let size = CGSize(width: LevitateSkillWidth, height: RolePhysicsBodySize.height/2)
        //let offsetY = role.position.y + role.size.height/2 + size.height/2
        //toSpaceCenterSize = offsetY
        super.init(role: role, texture: texture, color: UIColor.blue, size: size)
        position = CGPoint(x: role.position.x, y: role.position.y + size.height/2)
        
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





