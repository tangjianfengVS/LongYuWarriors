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

class LYWarriorsRole: SKSpriteNode {
    static let shared: LYWarriorsRole={
        let texture = SKTexture(imageNamed: "new_stop_0001")//"goblin_idle_0001")
        let role = LYWarriorsRole(texture: texture)
        let physicsBodySize = CGSize(width: LimitWidth, height: role.size.height)
        let center = CGPoint(x: (role.size.width - LimitWidth)/2, y: role.position.y)
        role.physicsBody = SKPhysicsBody(rectangleOf: physicsBodySize, center: center)
        //let path = CGPath(ellipseIn: CGRect(x: 0, y: 0, width: LimitWidth, height: role.size.height), transform: nil)
        //role.physicsBody = SKPhysicsBody(edgeLoopFrom: path)//SKPhysicsBody(edgeChainFrom: path)
        role.physicsBody?.isDynamic = true
        role.physicsBody?.categoryBitMask = UInt32(LYWarriorsMarginType.masterType.rawValue)
        role.physicsBody?.contactTestBitMask = UInt32(LYWarriorsMarginType.marginType.rawValue)
        return role
    }()
    
    /*
     *  属性
     */
    private(set) var id: String=""                             //ID
    private(set) var personFunc: LYWarriorsPersonFunc = .unKown//角色职业
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
}
