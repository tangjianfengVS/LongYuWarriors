//
//  LYWarriorsRole.swift
//  LongYuWarriors
//
//  Created by 汤建锋 on 2018/5/23.
//  Copyright © 2018年 AllOverTheSkyStar. All rights reserved.
//

import SpriteKit
import UIKit
//+ (SKPhysicsBody *)bodyWithRectangleOfSize:(CGSize)s;创建矩形的物理体
//+ (SKPhysicsBody *)bodyWithCircleOfRadius:(CGFloat)r;创建圆形的物理体
//+ (SKPhysicsBody *)bodyWithPolygonFromPath:(CGPathRef)path;创建自定义的物理体
//let path = CGPath(ellipseIn: CGRect(x: (role.size.width - RolePhysicsBodySize.width)/2-10,
//                                    y: -RolePhysicsBodySize.height/2,
//                                width: RolePhysicsBodySize.width,
//                               height: RolePhysicsBodySize.height), transform: nil)
//role.physicsBody = SKPhysicsBody(edgeLoopFrom: path)


//physicsBody属性：
//* area:             （不可变）
//* mass:             质量
//* density:          密度
//* friction:         摩擦力
//* linearDamping:    阻力
//* angularDamping:   角力（旋转的力 与环境有关）
//* resitution:       势能，（碰撞效果强弱） 0.0f － 1.0f
//* dynamic:          动态的physicsBody默认为YES，静态为NO
//* affectedByGravity:YES接受重力影响
//* allowsRotation:   NO 即为冻结旋转
//
//* force：持续的力 ，每一帧都要设置
//* impulse:瞬时的力
//* categoryBitMask:   标记了属于哪一类物体 默认：0xfffffffff
//* contactTestBitMask:标记了那些物体可以与其发生碰撞，并产生影响 默认：0x00000000
//* collisionBitMask:  标记了和那些物体可以碰撞 默认：0xfffffffff
//* usesPreciseCollisionDetection:  提高碰撞精度

class LYWarriorsRole: SKSpriteNode {
    let ShootSkillSpeed: CGFloat = 200
    private(set) var physicsBodyCenter: CGPoint?
    
    static let shared: LYWarriorsRole=LYWarriorsRole(person: .swordmanPerson,personClass: .masterClass)
//    private(set) var ATKGround: SKSpriteNode={
//        let node = SKSpriteNode(texture: nil, size: RoleATKPhysicsSize)
//        node.physicsBody = SKPhysicsBody(rectangleOf: RoleATKPhysicsSize)
//        node.physicsBody?.isDynamic = false
//        node.physicsBody?.categoryBitMask = UInt32(LYWarriorsMarginType.ATKAcceptType.rawValue)
//        node.physicsBody?.contactTestBitMask = UInt32(LYWarriorsMarginType.ATKScopeType.rawValue)
//        return node
//    }()
    
    class func rival(dict: [String:Any]) -> LYWarriorsRole{
        let role = LYWarriorsRole(person: .swordmanPerson, personClass: .defierClass)
        return role
    }
 
    init(person: LYWarriorsProfessionalType, personClass: LYWarriorsPersonClass) {
        professionalType = person
        let texture = SKTexture(imageNamed: "new_stop_0001")
        super.init(texture: texture, color: UIColor.cyan, size: texture.size())
        let center = CGPoint(x: (size.width - RolePhysicsBodySize.width/2)/2, y: position.y)
        physicsBodyCenter = center
        physicsBody = SKPhysicsBody(rectangleOf: RolePhysicsBodySize, center: center)
        physicsBody?.isDynamic = true
        physicsBody?.allowsRotation = false
        if personClass == .masterClass {
            physicsBody?.categoryBitMask = LYWarriorsMarginType.masterType.rawValue
        }else{
            physicsBody?.categoryBitMask = LYWarriorsMarginType.defierType.rawValue
        }
        physicsBody?.contactTestBitMask = LYWarriorsMarginType.defierType.rawValue | LYWarriorsMarginType.masterType.rawValue
        physicsBody?.collisionBitMask = LYWarriorsMarginType.marginType.rawValue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
     *  属性
     */
    let professionalType: LYWarriorsProfessionalType!   //角色职业
    private(set) var id: String=""                             //ID
    private(set) var userName: String=""                       //名称
    private(set) var skillFuncList: [Any] = []                 //技能集合
                                                               //技能设置（快捷键）
    private(set) var medalGrade: NSNumber=0                    //勋章等级
    private(set) var honorName: String=""                      //称号
    var locational: CGRect = .zero
    var direction: Bool = true{                                //方向
        didSet{
            //self.zPosition
//            let rotate = SKAction.rotate(byAngle: direction ? CGFloat(Double.pi) : CGFloat(-Double.pi), duration: 1)
//            let repeatAction = SKAction.repeat(rotate, count: 1)
//            run(repeatAction, withKey: "rotate")
            print(direction ? "调头--进":"调头--退")
        }
    }
    
    private let idleFarams: [SKTexture]={
        let textureAtlas = SKTextureAtlas(named: "New_stop")
        var rray: [SKTexture] = []
        for i in 1..<textureAtlas.textureNames.count{
            let texture = textureAtlas.textureNamed(String(format:"new_stop_%04zd",i))
            rray.append(texture)
        }
        return rray
    }()
    
    private let walkFarams: [SKTexture]={
        let textureAtlas = SKTextureAtlas(named: "New_run")//Goblin_Walk
        var rray: [SKTexture] = []
        for i in 1..<textureAtlas.textureNames.count{
            let texture = textureAtlas.textureNamed(String(format:"new_run_%04zd",i))//goblin_walk
            rray.append(texture)
        }
        return rray
    }()
    
    private let raiseFarams: [SKTexture]={
        let textureAtlas = SKTextureAtlas(named: "New_raise")
        var rray: [SKTexture] = []
        for i in 1..<textureAtlas.textureNames.count{
            let texture = textureAtlas.textureNamed(String(format:"new_raise_%04zd",i))
            rray.append(texture)
        }
        return rray
    }()
    
    func idle() {
        size = SKTexture(imageNamed: "new_stop_0001").size()
        let run = SKAction.animate(with: idleFarams, timePerFrame: 0.1)
        let repeatForeverRun = SKAction.repeatForever(run)
        self.run(repeatForeverRun)
    }
    
    func walk() {
        size = SKTexture(imageNamed: "new_run_0001").size()
        let run = SKAction.animate(with: walkFarams, timePerFrame: 0.10)
        let repeatForeverRun = SKAction.repeatForever(run)
        self.run(repeatForeverRun)
    }
    
    func raise() {
        size = SKTexture(imageNamed: "new_raise_0001").size()
        let run = SKAction.animate(with: raiseFarams, timePerFrame: 0.1)
        let repeatForeverRun = SKAction.repeat(run, count: 1)
        self.run(repeatForeverRun) {
            self.size = SKTexture(imageNamed: "new_stop_0001").size()
        }
    }
    //------------------------------------技能
    private let shockWaveFarams: [SKTexture]={
        let textureAtlas = SKTextureAtlas(named: "Skill")
        var rray: [SKTexture] = []
        for i in 1..<textureAtlas.textureNames.count{
            let texture = textureAtlas.textureNamed(String(format:"skill_%04zd",i))
            rray.append(texture)
        }
        return rray
    }()
    
    func shockWave(sceneSpace: SKSpriteNode) {
        let shootSkill = LYWarriorsShootSkill(role: self)
        sceneSpace.addChild(shootSkill)
        let length = sceneSpace.size.height/2 - shootSkill.toSpaceCenterSize
        let point = CGPoint(x: position.x, y: sceneSpace.size.height/2)
        let monsterMove = SKAction.move(to: point, duration: TimeInterval(length/ShootSkillSpeed))
        shootSkill.run(monsterMove) {
            shootSkill.removeFromParent()
        }
    }
    
    func levitateSkill(sceneSpace: SKSpriteNode) {
        let levitateSkill = LYWarriorsLevitateSkill(role: self)
        sceneSpace.addChild(levitateSkill)
        let point = CGPoint(x: position.x, y: levitateSkill.position.y + 60)
        let monsterMove = SKAction.move(to: point, duration: 0.2)
        levitateSkill.run(monsterMove) {
            levitateSkill.removeFromParent()
        }
    }
    
    func commonSkill(sceneSpace: SKSpriteNode) {
        let commonSkill = LYWarriorsCommonSkill(role: self)
        sceneSpace.addChild(commonSkill)
        let point = CGPoint(x: position.x, y: commonSkill.position.y + 60)
        let monsterMove = SKAction.move(to: point, duration: 0.2)
        commonSkill.run(monsterMove) {
            commonSkill.removeFromParent()
        }
    }
    
    func outrangebrakeSkill(sceneSpace: SKSpriteNode) {
        let outrangebrakeSkill = LYWarriorsOutrangebrakeSkill(role: self)
        sceneSpace.addChild(outrangebrakeSkill)
        let point = CGPoint(x: outrangebrakeSkill.position.x, y: outrangebrakeSkill.position.y + 40)
        let monsterMove = SKAction.move(to: point, duration: 1)
        outrangebrakeSkill.run(monsterMove) {
            outrangebrakeSkill.removeFromParent()
        }
    }
    
    func drawingChopSkill(sceneSpace: SKSpriteNode) {
        let drawingChopSkill = LYWarriorsDrawingChopSkill(role: self)
        sceneSpace.addChild(drawingChopSkill)
        let point = CGPoint(x: drawingChopSkill.position.x, y: drawingChopSkill.position.y)
        let monsterMove = SKAction.move(to: point, duration: 1)
        drawingChopSkill.run(monsterMove) {
            drawingChopSkill.removeFromParent()
        }
    }
}
